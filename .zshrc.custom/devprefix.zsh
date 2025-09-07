# ~/.zshrc.d/devprefix.zsh

## add tag to specify remote connection
# Original-Prompts einmal sichern
typeset -g ORIG_PROMPT="$PROMPT"
typeset -g ORIG_RPROMPT="$RPROMPT"

# Prefix dynamisch setzen, ohne das Theme zu zerstören
function devintel_prompt_prefix() {
  local tag="%K{yellow}%F{black}[ DEV_INTEL ]%f%k "

  # Nur bei SSH (entferne die if-Bedingung, wenn du es immer willst)
  if [[ -n $SSH_CONNECTION ]]; then
    PROMPT="${tag}${ORIG_PROMPT}"
    RPROMPT="$ORIG_RPROMPT"
  else
    PROMPT="$ORIG_PROMPT"
    RPROMPT="$ORIG_RPROMPT"
  fi
}

# adjust prompt by adding prefix
precmd_functions+=(devintel_prompt_prefix)

