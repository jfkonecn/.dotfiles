# Setup

## Add more context to Ollama Linux

```sh
sudo systemctl edit ollama
```

Add

```txt
[Service]
Environment="OLLAMA_CONTEXT_LENGTH=256000"
```

### Make `sudo systemctl edit` Use vim

```sh
sudo visudo
```

Add

```txt
Defaults:%sudo env_keep += "SYSTEMD_EDITOR"
```

Add to .zshrc file

```txt
export SYSTEMD_EDITOR=vim
```
