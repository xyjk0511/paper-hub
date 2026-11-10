---
name: paper-hub
description: "科研写作总控入口：任何论文/科研写作任务先加载本 skill，由它按“阶段 × 投稿去向”选出唯一主 skill 再执行——评估 idea、搭论文骨架、写 Introduction、起草正文、润色与中译英、中文稿改中文稿、去 AI 味、投稿前自审、统计与数据声明、参考文献核验、论文配图与 Draw.io 重建、会议 rebuttal 与期刊返修、基金申请书。Use FIRST for any research-paper or grant-proposal task instead of picking among nature-* skills, Supervisor-Skills, sloptrim or humanizer-zh yourself. Not for code, general docs, or non-academic copywriting (those go straight to sloptrim / humanizer-zh)."
---

# Paper Hub — 科研写作总控

本 skill 只做两件事：**选出一个主 skill 并执行它**，以及**在两套 skill 规则不同时给出裁决**。它自己不写论文正文，也不复制其他 skill 的规则。

下文的 `<SKILLS>` 指本文件所在目录的上一级，也就是 skill 安装目录（Claude Code 一般是 `~/.claude/skills`，Codex 一般是 `~/.codex/skills`）。各 skill 的详细分工见同目录 `INDEX.md`，测试依据见 `EVIDENCE.md`，来源与许可见 `THIRD_PARTY.md`。

三组来源：

- **nature 系**：`nature-writing` `nature-polishing` `nature-response` `nature-reviewer` `nature-statistics` `nature-data` `nature-ref-verifier`（另有支持包 `nature-shared`）。面向期刊稿件。
- **Supervisor 系**：11 个，面向 CS/AI 会议论文。CC BY-NC-SA 4.0，**禁止商用**。
- **去 AI 味**：`humanizer-zh`（中文规则清单）、`sloptrim` 和 `slop-guard`（英文本地检测器）。

## 0. 三道前置闸门（任何路由之前先过）

1. **商业用途闸门**。文件属于公司或商业项目（企业研发报告、结题验收材料、产品文档、对外交付物）时：
   - 不用 Supervisor 系任何一个 skill（许可禁止商用）。
   - 可以用：nature 系（Apache-2.0）、`humanizer-zh`（MIT）、`sloptrim`（Apache-2.0）、`slop-guard`（MIT）。
   - 告诉用户这条限制和原因。
2. **保密闸门**。未发表的稿件、基金申请书、含公司名或个人姓名的文件，不发给任何外部模型或第三方服务（其他厂商的模型、网页版对话、在线检测网站），除非用户在本次对话里明确同意。同意后仍先把姓名和单位名换成代号。
3. **要不要改闸门**（仅去 AI 味任务）。动手前先指出具体的 AI 写法句段。指不出来就告诉用户“不建议改”，并说明看到了什么。没有 AI 腔的文本改写后会变差（见 `EVIDENCE.md` 第 3 轮）。同时检查并报告比文风更要紧的问题：正文里残留的 AI 工作说明、占位符、日期或数字前后矛盾、可疑的参考文献条目。

## 1. 执行方式

1. 过第 0 节的闸门。
2. 判断任务处于哪个**阶段**（第 2 节），稿件的**投稿去向**属于哪一类：
   - **期刊类**：Nature 系、医学、生物、材料、物理等期刊稿件；学位论文和基金申请书也归此类。
   - **会议类**：CS/AI/数据库/NLP 会议论文（NeurIPS、ICML、ICLR、ACL、VLDB、SIGMOD 等）以及同风格的 arXiv 稿。
   - 上下文看不出且第 2 节该行分了两列 → 按第 4 节问一次。
3. 用一句话告诉用户选择：`论文路由：<主 skill>（阶段 / 去向）[+ <辅助 skill>：<何时用>]`。不等确认。
4. 加载主 skill：能用 skill 工具直接调用就调用；调用不到（例如被隐藏）就读取 `<SKILLS>/<name>/SKILL.md`，按该文件执行，它引用的 `references/` 按需读取。文件不存在 → 告诉用户未安装，改用同一行的另一个 skill。
5. 之后按主 skill 的流程执行。主 skill 让你“转交给某 skill”时，回到第 2 节按投稿去向重新选，不直接照它写的名字跳转。

## 2. 路由表

| 阶段 | 期刊类 | 会议类 |
|---|---|---|
| A. idea 值不值得做、新颖性、可行性 | `idea-evaluator` | `idea-evaluator` |
| B. 文献调研、综述 | 宿主自带的深度检索能力（Claude 的 deep-research、Codex 的 web search 等） | 同左 |
| C. 论文逻辑骨架（动笔前） | `nature-writing`（论证重构） | 技术论文 `tech-paper-template`；benchmark/评测论文 `benchmark-paper-template` |
| D. 写 Introduction | `nature-writing` | `intro-drafter` |
| E. 起草其他章节或整篇 | `nature-writing` | `paper-writer` |
| F. 润色、精简、中译英 | `nature-polishing`（只输出英文） | `paper-polish`（可输出中文或英文） |
| G. 去 AI 味 | 见第 3.3 节 | 见第 3.3 节 |
| H. 投稿前自审 | `nature-reviewer`，再加 `pre-submission-reviewer` 的第 2–6 步（写作细节、语法、LaTeX、图、禁用词） | `pre-submission-reviewer`；用户要“模拟三位审稿人”时再加 `nature-reviewer` |
| I. 统计报告审查 | `nature-statistics` | `nature-statistics` |
| J. 数据/代码可用性声明 | `nature-data` | `nature-data` |
| K. 参考文献逐条核验 | `nature-ref-verifier`（需要联网） | `nature-ref-verifier` |
| L. 图怎么设计（动机图、总览图、实验图） | `figure-designer` | `figure-designer` |
| M. 画数据图的代码 | 宿主自带的画图能力或 matplotlib 等 | 同左 |
| N. 把图片重建成可编辑 `.drawio` | `drawio-reconstruction` | `drawio-reconstruction` |
| O. 回复审稿意见 | `nature-response`（返修信、逐点回复、标红稿） | `rebuttal-guidance`（先出策略）；要成文见第 3.4 节 |
| P. “怎么用 AI 做科研”这类方法问题 | `vibe-research-workflow` | `vibe-research-workflow` |

补充：

- 首次投稿的 cover letter 等材料归 `nature-writing`。
- **基金申请书**（NSFC 等）没有专门的 skill。立项依据的论证用 `nature-writing`；科学问题是否成立用 `idea-evaluator`；中文润色按第 3.3 节的中文学术做法；参考文献用 `nature-ref-verifier`。研究基础、工作条件这类只有申请人掌握的内容，只列出缺什么，不代写。
- **中文稿改中文稿**只有 `paper-polish` 和 `humanizer-zh` 能做；`nature-polishing` 只有“英文”和“中文译成英文”两种模式。
- 商业文件不能用表里的 Supervisor 系：会议类各行改用同阶段的 nature 系，`idea-evaluator`、`figure-designer`、`drawio-reconstruction`、`rebuttal-guidance`、`vibe-research-workflow` 那几行由宿主模型直接完成，并照 3.1 的底线；中文稿改中文稿只用 `humanizer-zh` 的清单。

## 3. 求同存异

### 3.1 共同底线（所有路由都适用，任何 skill 都不能放宽）

- 不编造数据、实验、引用、行号、图号或审稿人没说过的话。
- 每个事实性表述要能追到用户材料或已核验的检索结果。引用未核验就不写进成稿；需要逐条核验时用 `nature-ref-verifier`。
- 润色不改变科学含义。可能改变含义的修改单独列出，由用户确认。
- 数据支撑不了的结论不替它辩护，直接指出。
- 最终决定归作者。给出评估和草稿，不替作者做学术判断。

### 3.2 两套规则不同时怎么办

| 分歧 | 裁决 |
|---|---|
| 缺材料时怎么标：`nature-*` 用 `AUTHOR_INPUT_NEEDED` 占位；`paper-writer`/`intro-drafter` 要求成稿里不留占位标签 | 按主 skill 的做法。主 skill 不留占位时，把缺的材料列在正文之外的说明里，不能因此编造内容来填空 |
| 严重级别：`pre-submission-reviewer` 用 CRITICAL / MAJOR / MINOR；`nature-reviewer` 用 Major（Blocking 是/否）/ Minor | 两个都跑时合并成一张清单：CRITICAL = Major 且 Blocking；MAJOR = Major 非 Blocking；MINOR = Minor。同一问题只列一次，注明两边都发现 |
| 输出语言：Supervisor 系默认英文正文 | 论文正文按目标期刊/会议的语言；解释、评估报告、修改说明用用户的语言 |
| 标点：`nature-reviewer` 和 `pre-submission-reviewer` 都限制 em dash | 一致，照做 |
| 审稿结构：`nature-reviewer` 固定 3 份互盲报告 + 综合；`pre-submission-reviewer` 是五维度清单 | 不合并流程。先跑主 skill 并定稿，再跑辅助 skill，最后按上面的级别对应合并 |

### 3.3 去 AI 味

先过第 0 节的三道闸门，再按下表选做法。

| 文本 | 谁来改 | 用什么找问题 |
|---|---|---|
| 中文非学术（公众号、博客、邮件、科普稿） | `humanizer-zh` 全流程 | 它的规则清单 |
| 中文学术（论文、学位论文、基金申请书），非商业 | `paper-polish`（输出中文）为主 | 再读 `humanizer-zh/SKILL.md`，只用其中的 AI 写法清单 |
| 中文公司文档（商业） | 只按 `humanizer-zh` 的清单改被点出的句段 | 同左；不用 `paper-polish` |
| 英文学术 | 期刊 `nature-polishing`，会议 `paper-polish` | `sloptrim` 和 `slop-guard` 两个检测器都跑 |
| 英文非学术（邮件、cover letter、简历、README、博客） | `sloptrim` 全流程，包括它的 Silence 规则 | 它自带的检测器 |

**学术和公司文本的硬规则，优先于任何检测分数：**

- 不把长句拆成一串短句。`sloptrim` 的 `sentence_monotony` 命中在学术稿里可以不处理。
- 不新增原文没有的话，包括解释性的半句和结尾总结句。
- 不删原文的限定词、枚举项和结尾的意义总结。夸大的总结可以收窄，不能整句删掉。
- 不用破折号把原来的分条枚举连成一个长句。
- 不采用 `humanizer-zh`“个性与灵魂 / 注入灵魂”部分：不加观点、第一人称反应、幽默和口语词。
- 不用 `sloptrim` 的“加入个人语气”（drastic mode），不做整篇重写。
- 可能改变结论强度的修改，单独列给用户确认。

**英文检测器的用法：**

1. `sloptrim`（0–100，**低**好）：`PYTHONIOENCODING=utf-8 python <SKILLS>/sloptrim/scripts/detect.py <文件>`，读 `ai_tell_score` 和命中的模式。`.tex` 文件要传文件路径，不要走 stdin。
2. `slop-guard`（0–100，**高**好）：`PYTHONIOENCODING=utf-8 python <SKILLS>/paper-hub/tools/slop-guard/sg.py -v <文件>`，读分数、违规句段和建议。缺 `typing_extensions` 时先 `pip install typing_extensions`。它不识别 LaTeX，`.tex` 里的命令可能被误报，只看正文句子的命中。
3. sloptrim ≤ 20 且 slop-guard ≥ 80 就不动。否则只改被标出的句段，最多改 3 轮。
4. 向用户报告两个检测器改前和改后的分数。这里不遵守 `sloptrim` 的 Silence 规则。
5. 两个检测器都没有中文规则，不要对中文用。中文没有本地检测器。
6. `sloptrim --clean` 只能重定向到**新的纯文本文件**，不能覆盖 `.docx`、`.epub`、`.ipynb` 原件。

分数只描述文字本身，不能用来判断是谁写的，也不保证能通过任何检测系统。低分不等于没有 AI 味，仍要人工读一遍。

### 3.4 回复审稿意见

- **期刊返修** → `nature-response` 全流程。遇到态度强硬或意见互相冲突的审稿人，可先读 `rebuttal-guidance` 的第 1–4 步判断审稿人心态和策略重点，再回到 `nature-response` 成文。
- **会议 rebuttal** → `rebuttal-guidance` 只给逐条策略，不出可直接粘贴的正文。用户明确要正文时：先交付策略，再按策略起草，起草时套用 `nature-response` 的红线（不编造实验和改动，缺的材料标 `AUTHOR_INPUT_NEEDED`），并遵守会议的字数限制。

## 4. 何时先问用户

只在下面三种情况问一个问题，其余直接选：

- 第 2 节该行两列不同（C、D、E、F、H、O），而上下文看不出投稿去向。问：“投期刊还是 CS/AI 会议？”
- 用户说“帮我改改这篇”，看不出是语言润色（F）、去 AI 味（G）还是内容重构（C/E）。
- 看不出文件是否属于商业用途，而路由结果会用到 Supervisor 系。

## 5. 已知限制

- 没有安装 Supervisor 的 `deep-research`（与宿主自带的检索功能重复）。
- `drawio-reconstruction` 导出 PNG 预览需要 draw.io 桌面版；未安装时只能产出 `.drawio` 文件并说明预览未验证。
- `sloptrim` 只装 skill 和检测器，不挂它的 hook。
- `slop-guard` 只是检测器，不是 skill。

## 6. 收尾检查

- 一次任务只用一个主 skill，辅助 skill 只在第 2、3 节写明的位置用。完成后需要下一阶段时，重新路由并告诉用户。
- 交付前对照 3.1 逐条自查。
- 改 `.docx` 时写到副本，不覆盖用户原件。
