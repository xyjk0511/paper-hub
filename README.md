# paper-hub

一个给 Claude Code 和 Codex 用的**科研写作总控 skill**。你只管说“帮我写 Introduction / 润色这段 / 投稿前自审 / 回审稿意见”，它按“写到哪一步 × 投期刊还是会议”从下面这些开源 skill 里挑一个来做，并在它们规则冲突时给出裁决：

- **nature 系**（期刊稿）：起草、英文润色与中译英、模拟审稿、统计审查、数据声明、参考文献逐条核验、返修回复。
- **Supervisor 系**（CS/AI 会议稿）：评估 idea、论文骨架、Introduction、正文、中文稿改中文稿、投稿前细查、配图设计、图片转 draw.io、rebuttal 策略。
- **去 AI 味**：中文用 humanizer-zh，英文用 sloptrim 和 slop-guard 两个本地检测器打分。

路由表、三道前置检查（商用、保密、要不要改）和冲突裁决都在 [`skills/paper-hub/SKILL.md`](skills/paper-hub/SKILL.md)；每条规则的测试依据在 [`EVIDENCE.md`](skills/paper-hub/EVIDENCE.md)。

## 安装

需要 `bash`、`curl`、`tar`；英文检测器另需 Python 3。

```bash
git clone https://github.com/xyjk0511/paper-hub.git
cd paper-hub
bash install.sh
```

- 不带参数时，装到已存在的 `~/.claude/skills` 和 `~/.codex/skills`；也可以把目标目录作为参数传入。
- 已经装过的同名 skill 不会被覆盖；只有 paper-hub 自己会先备份旧版再更新。
- **商用场景**：Supervisor 系的许可（CC BY-NC-SA 4.0）禁止商用。公司或商业项目请用 `NO_SUPERVISOR=1 bash install.sh`，paper-hub 遇到商业文件也会自动避开它。
- 装完重开会话。之后直接说论文需求即可；想手动指定，Claude Code 里输入 `/paper-hub`，Codex 里输入 `$paper-hub`。

## 不包含的东西

- 跨模型盲审、付费论文下载这类依赖个人账号和本地服务的工具没有放进来。投稿前自审默认是单模型模拟审稿。
- 文献调研和画数据图交给宿主自带的能力（Claude 的 deep-research、Codex 的联网检索等）。

## 许可

本仓库自己写的文件用 MIT。第三方 skill 各自沿用上游许可，详见 [`THIRD_PARTY.md`](skills/paper-hub/THIRD_PARTY.md)。
