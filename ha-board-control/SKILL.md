---
name: ha-board-control
description: "Control development boards (power on/off/restart) via Home Assistant REST API. Use whenever the user asks to turn on, turn off, reset, or restart a dev board by alias (e.g. K1, K3, board1)."
version: 1.0.0
author: troy
metadata:
  hermes:
    tags: [Smart-Home, HomeAssistant, DevBoard, IoT, Power-Control, Hardware]
prerequisites:
  commands: [curl]
  environment_variables: [HA_URL, HA_TOKEN, HA_DEVICES]
---

# HomeAssistant Board Control

Control development board power through Home Assistant switch entities.

## Environment Variables

All configuration lives in `~/.hermes/.env`:

- `HA_URL` — HA instance URL, e.g. `http://192.168.1.100:8123`
- `HA_TOKEN` — Long-Lived Access Token
- `HA_DEVICES` — Comma-separated alias-to-entity mapping:
  ```
  board1=switch.k1_gpio_gateway_reset1,k3=switch.k3_power
  ```

If any variable is missing when the user requests an action, ask them to provide it and then append it to `~/.hermes/.env`.
Do NOT save HA credentials to memory, config.yaml, or bashrc — always use `~/.hermes/.env`.
When the user provides a new device, ask for both the **alias** (what they call it) and the **entity_id** (the HA switch entity), and update `HA_DEVICES` in `.env`.

## Workflow

1. User says something like "重启 K3", "关掉开发板1", "turn on k1".
2. Parse the **alias** and **action** (on / off / restart).
3. Read `HA_URL`, `HA_TOKEN`, `HA_DEVICES` from env.
4. Resolve alias → entity_id from `HA_DEVICES`.
5. Run the built-in script:

```bash
bash <skill_dir>/scripts/ha_ctrl.sh <action> <entity_id> <HA_URL> <HA_TOKEN>
```

## Supported Actions

| Action    | Behavior                                      |
|-----------|-----------------------------------------------|
| `on`      | `turn_on` the switch entity                   |
| `off`     | `turn_off` the switch entity                  |
| `restart` | `turn_off` → sleep 3s → `turn_on` (power cycle) |

## Pitfalls

- Token must have permission to control the target switch entities.
- If `restart` doesn't reboot the board, the board may need a power cycle (`off` then `on`) instead of a reset pulse — ask the user which behavior they expect.
- Entity IDs are case-sensitive in HA.
- If the user gives an alias not in `HA_DEVICES`, ask them for the entity_id and suggest adding it to the env.
