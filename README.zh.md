# ohmyskills

我个人在 [Hermes Agent](https://hermes.sh) 上使用的 skill 合集。

Hermes skill 是可复用的流程模块，用于告诉 agent 如何执行特定任务——包括调用哪些工具、需要哪些环境变量、以及如何处理边界情况。将 skill 放入 `~/.hermes/skills/` 目录后，Hermes 会自动发现并使用它。

**语言：** [English](README.md) | [中文](README.zh.md)

---

## Skills

### `ha-board-control` — HomeAssistant 开发板控制

通过 Home Assistant REST API 控制开发板电源（开机 / 关机 / 重启）。适用于通过 HA 智能开关远程给嵌入式开发板断电重启。

**分类：** `smart-home`

**安装路径：**
```
~/.hermes/skills/smart-home/ha-board-control/
```

**安装步骤：**
```bash
mkdir -p ~/.hermes/skills/smart-home
cp -r ha-board-control ~/.hermes/skills/smart-home/
```

**所需环境变量**（添加到 `~/.hermes/.env`）：
```
HA_URL=http://<你的HA地址>:8123
HA_TOKEN=<你的长期访问令牌>
HA_DEVICES=board1=switch.your_entity_id,k3=switch.another_entity
```

- `HA_URL` — Home Assistant 实例地址
- `HA_TOKEN` — 长期访问令牌（在 HA → 个人资料 → 安全 中生成）
- `HA_DEVICES` — 逗号分隔的别名=entity_id 映射，对应你的各块开发板

**使用方式：** 安装后直接告诉 Hermes——*"重启开发板1"*、*"关掉 k3"*、*"给 board1 断电重启"*——它会自动处理。
