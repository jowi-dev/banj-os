echo "zsh loaded"
alias ls="lsd"
alias cat="bat"
#nvim by default
alias vim="nvim"
alias gpv='$HOME/bin/get_production_var.sh'


eval "$(/opt/homebrew/bin/brew shellenv)" . /opt/homebrew/opt/asdf/libexec/asdf.sh
. /opt/homebrew/opt/asdf/libexec/asdf.sh


# append completions to fpath
#fpath=(${ASDF_DIR}/completions $fpath)
## initialise completions with ZSH's compinit
#autoload -Uz compinit && compinit

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

eval "$(starship init zsh)"

#. /libexec/asdf.sh
#
#. /opt/homebrew/opt/asdf/libexec/asdf.sh
#
#. /opt/homebrew/opt/asdf/etc/bash_completion.d/asdf.bash


export PATH=/usr/local/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:/Applications/kitty.app/Contents/MacOS:/opt/homebrew/bin:/opt/homebrew/bin


. /opt/homebrew/opt/asdf/libexec/asdf.sh

export CC=clang
export CPP="clang -E"
export EGREP=egrep
export KERL_BUILD_DOCS=yes
export KERL_INSTALL_MANPAGES=yes
export KERL_USE_AUTOCONF=0
export wxUSE_MACOSX_VERSION_MIN=12.3

export KERL_CONFIGURE_OPTIONS="--disable-debug --disable-silent-rules --enable-dynamic-ssl-lib --enable-gettimeofday-as-os-system-time --enable-kernel-poll --without-javac --without-odbc"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
