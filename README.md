# ohmyskills

My personal skill collection for [Hermes Agent](https://hermes.sh).

Hermes skills are reusable procedural modules that teach the agent how to perform specific tasks — including which tools to call, what environment variables are needed, and how to handle edge cases. Drop a skill into your `~/.hermes/skills/` directory and Hermes will automatically discover and use it.

**Languages:** [English](README.md) | [中文](README.zh.md)

---

## Skills

### `ha-board-control` — HomeAssistant Board Control

Control development board power (on / off / restart) via the Home Assistant REST API. Useful for remotely power-cycling embedded dev boards connected to HA smart switches.

**Category:** `smart-home`

**Install path:**
```
~/.hermes/skills/smart-home/ha-board-control/
```

**Steps:**
```bash
mkdir -p ~/.hermes/skills/smart-home
cp -r ha-board-control ~/.hermes/skills/smart-home/
```

**Required environment variables** (add to `~/.hermes/.env`):
```
HA_URL=http://<your-ha-host>:8123
HA_TOKEN=<your-long-lived-access-token>
HA_DEVICES=board1=switch.your_entity_id,k3=switch.another_entity
```

- `HA_URL` — URL of your Home Assistant instance
- `HA_TOKEN` — Long-Lived Access Token (generate in HA → Profile → Security)
- `HA_DEVICES` — Comma-separated alias=entity_id pairs for your boards

**Usage:** Once installed, just tell Hermes naturally — *"restart board1"*, *"turn off k3"*, *"power cycle board1"* — and it will handle the rest.
