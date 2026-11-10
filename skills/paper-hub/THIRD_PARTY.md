# 第三方来源

paper-hub 自身只做路由。下列项目由 `install.sh` 从上游按固定版本下载，原样安装，不随本仓库分发；只有 slop-guard 的源码随本仓库附带。许可于 2026-11-09 用 GitHub API 核对。

| 项目 | 来源 | 版本（commit） | 许可 | 安装内容 |
|---|---|---|---|---|
| nature-skills | https://github.com/Yuan1z0825/nature-skills | `b543e8b998eb2df1fd44641cc8b262c638c2b442` | Apache-2.0 | `skills/` 下 7 个 + `nature-shared` |
| Supervisor-Skills | https://github.com/HKUSTDial/Supervisor-Skills | `207bc6f7a1aa107e544099c2c7cc86816fba9628` | CC BY-NC-SA 4.0（**禁止商用**） | `skills/` 下 11 个，未装 `deep-research`；许可全文另存为 `SUPERVISOR-LICENSE.txt` |
| sloptrim | https://github.com/seyedehsanhadi/sloptrim | `38dbb7cb4e97de0b9bf157903c95bdcab016dda2`（v0.9.4） | Apache-2.0 | `SKILL.md`、`scripts/`、`references/`、`ETHICS.md`、`LICENSE.txt`、`NOTICE`；不装 hooks |
| Humanizer-zh | https://github.com/op7418/Humanizer-zh | `f4518a8eab97b8bfebc66a89d34320a89bef6930` | MIT | `SKILL.md`、`LICENSE`、`README.md` |
| slop-guard | https://github.com/eric-tramel/slop-guard | `7ef2113c52f1b4765287f90ac0741b2051d66fcb` | MIT（Eric Tramel） | 随本仓库附带于 `tools/slop-guard/`：`src/slop_guard` 源码未改动，`LICENSE` 保留；`sg.py` 是免安装调用其 CLI 的包装 |
