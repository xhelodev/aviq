# AVIQ

Command-line script for quick AI answers from your terminal, powered by coding agent CLIs (opencode, Claude Code, pi or Codex). Instead of calling an API directly, it delegates to an installed agent CLI, which handles its own authentication and can inspect the directory you are in.

Ask things like `aviq what's in this directory` or `aviq command to inspect the database`, get a short answer, and run the suggested command by pressing Enter.

## 🚀 Installation

### Quick install (one line)

Requires `~/.local/bin` in your PATH (default on most distros; re-login after running this if `aviq` is not found):

```bash
mkdir -p ~/.local/bin && curl -fsSL https://raw.githubusercontent.com/xhelodev/aviq/main/aviq -o ~/.local/bin/aviq && chmod +x ~/.local/bin/aviq
```

To update later, run the same line again. No configuration needed — the script uses the first agent CLI it finds. If you installed the previous `ai` command, remove `~/.local/bin/ai` after installing AVIQ if you no longer need it.

### From the repository

1. Install the script:
```bash
# Create Scripts directory if it doesn't exist
mkdir -p $HOME/Scripts && cd $HOME/Scripts

# Download the script directly to Scripts
git clone https://github.com/xhelodev/aviq.git ./
chmod +x aviq
```

2. Make the command available globally:

For bash (add to the end of `~/.bashrc`):
```bash
echo 'export PATH="$HOME/Scripts:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

For zsh (add to the end of `~/.zshrc`):
```bash
echo 'export PATH="$HOME/Scripts:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

3. Optional configuration:

The script works out of the box. To change the default settings, copy the example and edit it (or create the file from scratch if you installed with the one-liner):
```bash
cp .config.example .config
```

Available variables:
```bash
BACKENDS="pi opencode claude codex"   # first installed CLI wins
MODEL=""                              # optional, backend-specific format
PROMPT="answer in a few lines, ..."   # instructions for the model
```

The `AI_BACKENDS`, `AI_MODEL` and `AI_PROMPT` environment variables take precedence over the config file.

## 📝 Usage

### 1. Direct query
Ask a question from the command line. The agent can look at the current directory:
```bash
aviq what's in this directory

aviq command to inspect the database

aviq how do I create a directory in Linux
```

### 2. Using pipe (|)
Send file content or command output as context:
```bash
cat myfile.txt | aviq What does this code do

ls -la | aviq Explain these files
```

### 3. Running suggested commands
When the answer includes shell commands in code blocks and you are in an interactive terminal, the script offers to run them:

- One command: press **Enter** to run it, anything else to cancel.
- Several commands: a numbered menu is shown, type the number and press **Enter**.

Commands run in a child shell, so a `cd` or `export` inside them won't persist in your session.

### 4. Options
```bash
aviq -b claude "force a specific backend"
aviq -m sonnet "use a specific model for this query"
aviq -l                  # list available backends
aviq -n "ask without offering to run commands"
aviq --help
```

## ⚙️ Requirements

- bash or zsh
- One of these agent CLIs, installed and logged in (each manages its own auth):
  - [opencode](https://opencode.ai)
  - [Claude Code](https://platform.claude.com/docs/en/cli-sdks-libraries/cli/quickstart)
  - [pi](https://github.com/badlogic/pi-mono)
  - [Codex](https://github.com/openai/codex)

No API keys, `curl` or `jq` needed.

## 🤝 Contributing

Contributions are welcome. Please open an issue or pull request.
