# To install, create a symlink, then change the default theme to the new one
# ln -s $HOME/Forge/sethcottam.zsh-theme .oh-my-zsh/themes/sethcottam.zsh-theme
# Then modify the .zshrc ZSH_THEME="sethcottam"

# Some examples of Themes
# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
# https://stackoverflow.com/questions/34623956/how-to-get-absolute-path-on-a-zsh-prompts

SETHCOTTAM_LOGO="%{$FG[026]%}Seth%{$FG[242]%}Cottam%{$reset_color%}"
SETHCOTTAM_LOGO_BAD="%{$FG[124]%}Seth%{$FG[242]%}Cottam%{$reset_color%}"

# Original from robbyrussel
# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
# PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

# These Git variables are used by the oh-my-zsh git_prompt_info helper:X

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg[green]%}✓"  # git:(develop) ✓
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"  # git:(develop) ✗

# Build the prompt line
PROMPT="%(?:$SETHCOTTAM_LOGO:$SETHCOTTAM_LOGO_BAD) "
# PROMPT+="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+='%{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)%'

# Changelist
#	- Swapped %c for %~ - Changed showing current folder to showing the full path from home

# New addition that overrides the prompt if desided. I think this can be set anywhere that's loaded
# PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[green]%}Location: %~%{$reset_color%}$(git_prompt_info) '