# ~/.zshrc.d/devprefix.zsh

## add tag to specify remote connection
# save original tag first
typeset -g ORIG_PROMPT="$PROMPT"
typeset -g ORIG_RPROMPT="$RPROMPT"

# set tag with respecting original theme
function devintel_prompt_prefix() {
  [[ -z "$PROMPT_TAG" ]] && return

  local tag_text="${PROMPT_TAG}"
  local tag="%K{yellow}%F{black}[ ${tag_text} ]%f%k "

  # only in case of ssh connections
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

