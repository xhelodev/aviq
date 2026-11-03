#!/bin/bash
set -eu
cd "$(dirname "$0")/.."
# Exercise the production parser with multiple blocks, whitespace and backslashes.
parser=$(sed -n '/^BLOCKS=$(awk /,/^# ---.*offer to run them/p' aviq)
RESPONSE=$'```bash\nprintf "%s\\n" "a b"\necho second\n```\n```sh\necho last\n```'
# Model Bash versions where mapfile is unavailable.
mapfile() { return 127; }
eval "$parser"
[[ ${#COMMANDS[@]} -eq 2 ]]
[[ ${COMMANDS[0]} == $'printf "%s\\n" "a b"\necho second' ]]
[[ ${COMMANDS[1]} == 'echo last' ]]
RESPONSE='plain answer'
eval "$parser"
[[ ${#COMMANDS[@]} -eq 0 ]]
printf 'Parser checks passed\n'
