# paper-hub 分工索引

给人查的索引，也是 paper-hub 的参考表。下表“隐藏”指可在宿主里设为只能手动调用，以免和总控抢着触发；不隐藏也能用。

## 科研写作（入口：`paper-hub`）

### 2.1 按阶段查

| 阶段 | 期刊稿、学位论文、基金申请书 | CS/AI 会议稿 |
|---|---|---|
| 评估 idea | idea-evaluator | idea-evaluator |
| 文献调研 | 宿主自带检索 | 宿主自带检索 |
| 搭骨架 | nature-writing | tech-paper-template / benchmark-paper-template |
| 写 Introduction | nature-writing | intro-drafter |
| 写正文 | nature-writing | paper-writer |
| 润色、中译英 | nature-polishing | paper-polish |
| 中文稿改中文稿 | paper-polish | paper-polish |
| 去 AI 味 | 见 2.4 | 见 2.4 |
| 投稿前自审 | nature-reviewer + pre-submission-reviewer 的细节检查 | pre-submission-reviewer |
| 统计 | nature-statistics | nature-statistics |
| 数据/代码声明 | nature-data | nature-data |
| 参考文献核验 | nature-ref-verifier | nature-ref-verifier |
| 图的设计 | figure-designer | figure-designer |
| 画数据图 | 宿主自带画图 | 宿主自带画图 |
| 图片转 Draw.io | drawio-reconstruction | drawio-reconstruction |
| 回审稿意见 | nature-response | rebuttal-guidance |

### 2.2 nature 系（7 个 + 1 个支持包；可见；商用：可，Apache-2.0）

| Skill | 做什么 | 你要给它 | 它交付 | 不做什么 |
|---|---|---|---|---|
| nature-writing | 起草或重构论文的论证和章节；首次投稿材料（cover letter 等） | 你的数据、结果、要点 | 章节正文或重构后的论证；缺材料处标 `AUTHOR_INPUT_NEEDED` | 只改语言的活（交给 nature-polishing）；返修信 |
| nature-polishing | 润色、精简已有英文；中文译成投稿级英文；LaTeX 排版修正 | 已有段落或稿件 | 英文润色稿 | 中文改中文；重写论证 |
| nature-response | 期刊返修：逐点回复、返修信、标红稿、LaTeX 返修包 | 编辑信、审稿意见、稿件 | 每位审稿人一份回复 + 总策略表 + 一致性检查 | 模拟审稿；首次投稿材料 |
| nature-reviewer | 模拟审稿：3 份互盲审稿报告 + 1 份综合 | 稿件或节选 | Major / Minor 问题清单，每条带证据位置 | 替作者写回复 |
| nature-statistics | 审查统计报告：实验单位、重复、不确定性、检验、图注统计 | 方法、结果、图注 | 问题清单和改写建议 | 默认不做新分析，除非给数据并要求 |
| nature-data | 数据/代码可用性声明、仓库选择、FAIR 元数据 | 数据集情况 | 声明文本和仓库方案 | 数据清洗、统计分析 |
| nature-ref-verifier | 参考文献逐条多源核验：作者、标题、年份、卷期、页码、DOI | 参考文献列表或单条 | 结构化核验报告；可同步 Zotero | 需要联网（Crossref 等）；只发送文献条目 |
| nature-shared | 上面几个共用的参考文件 | — | — | 不单独使用 |

### 2.3 Supervisor 系（11 个；隐藏；商用：禁）

来源：HKUSTDial/Supervisor-Skills，CC BY-NC-SA 4.0。只用于自己的非商业学术写作。

| Skill | 做什么 | 你要给它 | 它交付 | 不做什么 |
|---|---|---|---|---|
| idea-evaluator | 评估研究 idea：五维评分（更高、更快、更强、更省、更广）、致命缺陷检查、生命周期与能力匹配、范式转移探查 | 一个初步 idea | 审稿人式结论和分项评分 | 写论文 |
| tech-paper-template | 技术论文的逻辑骨架：背景、局限、关键想法、挑战、方法模块、贡献；四项自洽检查 | 研究内容要点 | 填好的思考模板表 + 自洽检查结果 | 写正文 |
| benchmark-paper-template | Benchmark/评测论文的骨架：五支柱完整性、Intro 六段逻辑链、第 2–7 节提纲、投稿前检查表 | benchmark 的设计情况 | 完整性表 + 提纲 | 技术方法论文 |
| intro-drafter | 写 Introduction 正文，内部按六段流程：背景与例子、现有局限、问题本质、挑战、方案、贡献；引用经检索核验 | 研究动机和贡献 | 连贯正文（或按要求只给提纲） | 其余章节 |
| paper-writer | 从你的材料起草正文，单段到整篇；每个事实可溯源，引用独立核验，成稿不留占位标签 | 材料、结果、文献 | 干净正文 | 润色已有稿；评估 idea |
| paper-polish | 忠于原意的润色：语法、流畅度、措辞强度校准、去 AI 腔、中译英；**可输出中文** | 已有稿件 | 润色稿 + 可能改变含义的修改清单 | 重写内容；论证有问题时只指出不硬改 |
| pre-submission-reviewer | 投稿前五维审查：宏观逻辑、写作细节、英文语法、LaTeX 格式、图质量；禁用词和 em dash 扫描 | 完整草稿 | CRITICAL / MAJOR / MINOR 清单 + 1–10 分 + 投稿建议 | 替你改稿 |
| figure-designer | 三类核心图的设计建议：动机图、方法总览图、实验结果图；选范式、布局、标注、工具 | 想表达什么 | 设计方案 + 质量检查 | 不画图 |
| drawio-reconstruction | 把参考图、论文图、架构图、截图重建成可编辑 `.drawio` | 图片或图片文件夹 | `.drawio` 文件 + 视觉核对 | 导出 PNG 预览需要 draw.io 桌面版 |
| rebuttal-guidance | 会议 rebuttal 策略：给每条意见分类、判断审稿人心态、匹配回应策略 | 审稿意见 | 逐条回应指导（不是可粘贴正文） | 不直接写 rebuttal 正文 |
| vibe-research-workflow | “怎么用 AI 做科研”的方法指导：写代码、作图、写作三条流程和工具选择 | 一个方法问题 | 流程建议 | 具体论文任务 |

### 2.4 去 AI 味

| 工具 | 类型 | 语言 | 分数方向 | 位置 | 可见 | 商用 |
|---|---|---|---|---|---|---|
| humanizer-zh | 规则清单 + 改写流程（24 类 AI 写法） | 中文 | 无检测器 | `humanizer-zh/` | 可见 | 可（MIT） |
| sloptrim | 检测器 + 改写流程（71 类模式） | 英文 | 0–100，低好 | `sloptrim/scripts/detect.py` | 隐藏 | 可（Apache-2.0） |
| slop-guard | 只有检测器（24 条规则） | 英文 | 0–100，高好 | `paper-hub/tools/slop-guard/sg.py` | 不是 skill | 可（MIT） |

按文本选做法：

| 文本 | 做法 |
|---|---|
| 中文非学术 | humanizer-zh 全流程 |
| 中文学术（非商业） | paper-polish 为主，只借 humanizer-zh 的清单，不加主观语气 |
| 中文公司文档 | 只按 humanizer-zh 清单改被点出的句段 |
| 英文学术 | 润色 skill 改，sloptrim 和 slop-guard 两个都打分 |
| 英文非学术 | sloptrim 全流程 |

动手前先判断要不要改：指不出具体 AI 写法的文本不改。

### 2.5 功能重叠时谁说了算

| 功能 | 两边都有 | 裁决 |
|---|---|---|
| 写正文 | nature-writing、paper-writer | 按投稿去向：期刊用前者，会议用后者 |
| 润色 | nature-polishing、paper-polish | 同上；要输出中文只能用 paper-polish |
| 自审 | nature-reviewer、pre-submission-reviewer | 前者看科学意义和有效性，后者看写作、语法、LaTeX、图。可先后都跑，结果合并 |
| 回审稿 | nature-response、rebuttal-guidance | 前者出成文的返修包，后者只出策略 |
| 去 AI 腔 | paper-polish 的一节、humanizer-zh、sloptrim | 见 2.4 |
| 文献调研 | 宿主自带检索、Supervisor 的 deep-research | 后者未安装 |

