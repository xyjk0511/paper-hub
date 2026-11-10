#!/usr/bin/env bash
# paper-hub 安装脚本：把 paper-hub 和它路由到的第三方 skill 装进一个或多个 skill 目录。
# 用法：bash install.sh [skill目录...]
#   不给参数时，装到已存在的 ~/.claude/skills 和 ~/.codex/skills。
#   已存在的同名 skill 不覆盖（paper-hub 自身除外，会先备份再更新）。
# 环境变量：NO_SUPERVISOR=1 跳过 Supervisor 系（禁止商用，商业场景请设置）。
set -eo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
NATURE_SHA=b543e8b998eb2df1fd44641cc8b262c638c2b442
SUPERVISOR_SHA=207bc6f7a1aa107e544099c2c7cc86816fba9628
SLOPTRIM_SHA=38dbb7cb4e97de0b9bf157903c95bdcab016dda2
HUMANIZER_SHA=f4518a8eab97b8bfebc66a89d34320a89bef6930

NATURE_SKILLS="nature-writing nature-polishing nature-response nature-reviewer nature-statistics nature-data nature-ref-verifier nature-shared"
SUPERVISOR_SKILLS="idea-evaluator tech-paper-template benchmark-paper-template intro-drafter paper-writer paper-polish pre-submission-reviewer figure-designer drawio-reconstruction rebuttal-guidance vibe-research-workflow"

targets=("$@")
if [ ${#targets[@]} -eq 0 ]; then
  for d in "$HOME/.claude/skills" "$HOME/.codex/skills"; do [ -d "$d" ] && targets+=("$d"); done
fi
if [ ${#targets[@]} -eq 0 ]; then
  echo "没找到 ~/.claude/skills 或 ~/.codex/skills，请把 skill 目录作为参数传进来。" >&2; exit 1
fi

TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
fetch() { # fetch owner/repo sha -> 解压目录路径
  local repo=$1 sha=$2 out="$TMP/${1//\//_}"
  mkdir -p "$out"
  curl -fsSL "https://codeload.github.com/$repo/tar.gz/$sha" | tar -xz -C "$out" --strip-components=1
  echo "$out"
}

echo "下载上游仓库（固定版本）..."
NATURE=$(fetch Yuan1z0825/nature-skills $NATURE_SHA)
SLOPTRIM=$(fetch seyedehsanhadi/sloptrim $SLOPTRIM_SHA)
HUMANIZER=$(fetch op7418/Humanizer-zh $HUMANIZER_SHA)
[ "${NO_SUPERVISOR:-0}" = 1 ] || SUPERVISOR=$(fetch HKUSTDial/Supervisor-Skills $SUPERVISOR_SHA)

put() { # put 源目录 目标目录 名称
  if [ -e "$2/$3" ]; then echo "  跳过 $3（已存在）"; return; fi
  cp -R "$1" "$2/$3"; echo "  安装 $3"
}

for T in "${targets[@]}"; do
  echo "== $T"
  mkdir -p "$T"
  if [ -e "$T/paper-hub" ]; then
    bak="$T/paper-hub.bak.$(date +%Y%m%d%H%M%S)"; mv "$T/paper-hub" "$bak"; echo "  旧 paper-hub 已备份到 $bak"
  fi
  cp -R "$HERE/skills/paper-hub" "$T/paper-hub"; echo "  安装 paper-hub"

  for s in $NATURE_SKILLS; do put "$NATURE/skills/$s" "$T" "$s"; done

  if [ ! -e "$T/sloptrim" ]; then
    mkdir -p "$T/sloptrim"
    cp -R "$SLOPTRIM/SKILL.md" "$SLOPTRIM/scripts" "$SLOPTRIM/references" "$SLOPTRIM/ETHICS.md" "$SLOPTRIM/LICENSE.txt" "$SLOPTRIM/NOTICE" "$T/sloptrim/"
    echo "  安装 sloptrim（不含 hooks）"
  else echo "  跳过 sloptrim（已存在）"; fi

  if [ ! -e "$T/humanizer-zh" ]; then
    mkdir -p "$T/humanizer-zh"; cp "$HUMANIZER/SKILL.md" "$HUMANIZER/LICENSE" "$HUMANIZER/README.md" "$T/humanizer-zh/"
    echo "  安装 humanizer-zh"
  else echo "  跳过 humanizer-zh（已存在）"; fi

  if [ "${NO_SUPERVISOR:-0}" = 1 ]; then
    echo "  按 NO_SUPERVISOR=1 跳过 Supervisor 系"
  else
    for s in $SUPERVISOR_SKILLS; do put "$SUPERVISOR/skills/$s" "$T" "$s"; done
    if [ ! -e "$T/SUPERVISOR-LICENSE.txt" ] && [ -f "$SUPERVISOR/LICENSE" ]; then cp "$SUPERVISOR/LICENSE" "$T/SUPERVISOR-LICENSE.txt"; fi
  fi
done

echo
echo "完成。自检英文检测器："
P=""
for c in python3 python; do
  if command -v "$c" >/dev/null 2>&1 && "$c" -c 'import sys; sys.exit(sys.version_info < (3, 8))' >/dev/null 2>&1; then P=$c; break; fi
done
if [ -n "$P" ]; then
  printf 'This is a short test sentence. It delves into a rich tapestry of ideas.
' > "$TMP/t.txt"
  # 检测器发现问题时退出码可能非 0，所以按输出判断
  PYTHONIOENCODING=utf-8 "$P" "${targets[0]}/paper-hub/tools/slop-guard/sg.py" "$TMP/t.txt" 2>&1 | grep -q '/100'     && echo "  slop-guard 正常" || echo "  slop-guard 失败：先运行 $P -m pip install typing_extensions 再试"
  PYTHONIOENCODING=utf-8 "$P" "${targets[0]}/sloptrim/scripts/detect.py" "$TMP/t.txt" 2>&1 | grep -q 'ai_vocabulary'     && echo "  sloptrim 正常" || echo "  sloptrim 失败：看 ${targets[0]}/sloptrim/SKILL.md 的依赖说明"
else
  echo "  没找到可用的 Python 3，两个英文检测器暂时用不了。"
fi
echo "重开 Claude Code / Codex 会话后生效。"
