# To install, create a symlink, then change the default theme to the new one
# ln -s $HOME/Forge/blytzpay.zsh-theme .oh-my-zsh/themes/blytzpay.zsh-theme
# Then modify the .zshrc ZSH_THEME="blytzpay"

# These Git variables are used by the oh-my-zsh git_prompt_info helper:X
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg[green]%}✓"  # git:(develop) ✓
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"  # git:(develop) ✗

# Use `spectrum_ls` to view all the possible zsh colors
# Using the number require $FG[002] instead of $fg[002], but you loose access to stuff like bold

BLYTZPAY_LOGO_SIMPLE="%{$FG[117]%}≡blytz%{$reset_color%}pay"
BLYTZPAY_LOGO="%{$FG[111]%}≡%{$FG[117]%}b%{$FG[116]%}l%{$FG[079]%}y%{$FG[086]%}t%{$FG[085]%}z%{$FG[254]%}pay%{$reset_color%}"  # ≡blytzpay (Blue-ish colors)
BLYTZPAY_LOGO_BAD="%{$FG[165]%}≡%{$FG[164]%}b%{$FG[163]%}l%{$FG[162]%}y%{$FG[161]%}t%{$FG[160]%}z%{$FG[240]%}pay%{$reset_color%}"  # ≡blytzpay (Red-ish colors)

# Build the prompt line

# Option 1 (Color changing logos on bad input)
PROMPT="%(?:$BLYTZPAY_LOGO:$BLYTZPAY_LOGO_BAD)"
PROMPT+=' %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)%'
# Changelist
#	- Swapped %c for %~ - Changed showing current folder to showing the full path from home

# Option 2 (Normal logo. Green mini icon on success. Red mini icon on failure.)
# PROMPT="$BLYTZPAY_LOGO"
# PROMPT+="%(?:%{$fg_bold[green]%} ≡b:%{$fg_bold[red]%} ≡b)"
# PROMPT+=' %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)%'
# Changelist
#	- Swapped %c for %~ - Changed showing current folder to showing the full path from home

# Option 3 (Normal logo)
# PROMPT="$BLYTZPAY_LOGO"
# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
# PROMPT+=' %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)%'
# Changelist
#	- Swapped %c for %~ - Changed showing current folder to showing the full path from home