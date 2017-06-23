# ~/.bashrc: executed by bash(1) for non-login shells.
# Do not export PS1, HISTFILE, etc. (https://unix.stackexchange.com/a/197333)

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

case "$TERM" in
    xterm-color|*-256color|screen) color_prompt=yes;;
esac

if [ -f "/google/devshell/bashrc.google" ]; then
  source "/google/devshell/bashrc.google"
fi


# uncomment for a colored prompt, if the terminal has the capability; turned off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48 (ISO/IEC-6429). (Lack of such support is extremely rare, and such a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi


my_long_name=$(hostname)

if command -v sudo 1>/dev/null 2>&1; then
  alias sudoc='sudo '
else
  alias sudoc=
fi

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth:erasedups

# Ignore list for history
HISTIGNORE="&:[bf]g:clear:fg:ll:h:ls"

# If the HISTTIMEFORMAT is set, the time stamp information associated with each history entry is written to the history file, marked with the history comment character.
HISTTIMEFORMAT="%d/%m/%y %T "

# Set history length
# HISTSIZE     ==> current shell
HISTSIZE=10000
# HISTFILESIZE ==> length in the file
HISTFILESIZE=40000

# Time format for bash command "time"
# %[p][l]R ==> The elapsed time in seconds.
# %[p][l]U ==> The number of CPU seconds spent in user mode.
# %[p][l]S ==> The number of CPU seconds spent in system mode.
# %P       ==> The CPU percentage, computed as (%U + %S) / %R.
# The optional p is a digit specifying the precision, the number of fractional digits after a decimal point. A value of 0 causes no decimal point or fraction to be output. At most three places after the decimal point may be specified; values of p greater than 3 are changed to 3. If p is not specified, the value 3 is used.
# The optional l specifies a longer format, including minutes, of the form MMmSS.FFs. The value of p determines whether or not the fraction is included.
TIMEFORMAT=$'\n  %2lR\tuser  %2lU\tsys  %2lS\tpcpu %P\n'


# Time format for GNU command "/usr/bin/time"
TIME="\nTime taken: %E  \nCPU total: %P   CPU system: %Ss   CPU user: %Us\nMemory avg: %k Kb   Memory max:  %M Kb"
alias time='/usr/bin/time'

# append to the history file, don't overwrite it
shopt -s histappend

# Default file permissions
# https://www.cyberciti.biz/tips/understanding-linux-unix-umask-value-usage.html
# file will be created with 640 (666 - 026)
# dir  will be created with 750 (777 - 027)
# umask 027
umask u=rwx,g=rx,o=


# Does a command exist?
has() {
  type "$1" > /dev/null 2>&1
  return $?
}


# On teste si le français est disponible
locale -a 2>&1 | grep -i fr_FR.utf8 > /dev/null
if [ $? = 0 ]; then
  export LC_ALL=fr_FR.utf8
  export LANG=fr_FR.utf8
else
  export LC_ALL=en_US.utf8
  export LANG=en_US.utf8
fi

# check the window size after each command and, if necessary,  update the values of LINES and COLUMNS.
shopt -s checkwinsize

# ls case insensitive patterns (x and X is the same for ls)
shopt -s nocaseglob

# If set, the pattern "**" used in a pathname expansion context will match all files and zero or more directories and subdirectories.
#shopt -s globstar ==> Do not activate this do to the subdirectories expansion

# If set, Bash includes filenames beginning with a '.' in the results of filename expansion.
shopt -s dotglob

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Add to PATH usefull folders
for x in /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin $HOME/bin $HOME/.local/bin $HOME/.gems/bin; do
  case ":$PATH:" in
    *":$x:"*) :;; # already there
    *) # add the folder to PATH if it exists
      if [ -d $x ] ; then
        PATH+=":$x"
      fi
    ;;
  esac
done
export PATH=$PATH
unset x


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  # test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias   ls='ls   --color=auto'
  alias  dir='dir  --color=auto'
  alias vdir='vdir --color=auto'

  alias  grep='grep  --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi



# Add an "alert" alias for long running commands.  Use like so: sleep 10; alert
#alias alert='notify-send --urgency=low -i "$([ $? == 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable this, if it's already enabled in /etc/bash.bashrc and /etc/profile sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



### Show colors for BASH ###
# ansi-test() {
      # for a in 0 1 4 5 7; do
              # echo "a=$a " 
              # for (( f=0; f<=9; f++ )) ; do
                      # for (( b=0; b<=9; b++ )) ; do
                              # echo -ne "\\033[${a};3${f};4${b}m"
                              # echo -ne "\\\\\\\\033[${a};3${f};4${b}m"
                              # echo -ne "\\033[0m "
                      # done
              # echo
              # done
              # echo
      # done
      # echo
# }


# Colors
# https://github.com/jimeh/git-aware-prompt/blob/master/colors.sh

# Black='\e[0;30m'        # Black
# Red='\e[0;31m'          # Red
# Green='\e[0;32m'        # Green
# Yellow='\e[0;33m'       # Yellow
# Blue='\e[0;34m'         # Blue
# Purple='\e[0;35m'       # Purple
# Cyan='\e[0;36m'         # Cyan
# White='\e[0;37m'        # White

# Black=$(tput setaf 0)       # Black
# Red=$(tput setaf 1)         # Red
# Green=$(tput setaf 2)       # Green
Yellow="$(tput setaf 3 2>/dev/null || echo '\e[0;33m')"      # Yellow
Blue="$(tput setaf 4 2>/dev/null || echo '\e[0;34m')"        # Blue
# Purple=$(tput setaf 5)      # Purple
# Cyan=$(tput setaf 6)        # Cyan \e[36m
White="$(tput setaf 7 2>/dev/null || echo '\e[0;37m')"       # White

# Bold
BBlack="$(tput setaf 0 2>/dev/null)$(tput bold 2>/dev/null || echo '\e[1;30m')"       # Black
# BRed='\e[1;31m'         # Red
# BGreen='\e[1;32m'       # Green
# BYellow='\e[1;33m'      # Yellow
# BBlue='\e[1;34m'        # Blue
# BPurple='\e[1;35m'      # Purple
# BCyan='\e[1;36m'        # Cyan
BWhite="$(tput setaf 0 2>/dev/null)$(tput bold 2>/dev/null || echo '\e[1;37m')"       # White

# Background
# On_Black=$(tput setab 0)  # Black
# On_Red=$(tput setab 1)    # Red
# On_Green=$(tput setab 2)  # Green
# On_Yellow=$(tput setab 3) # Yellow
On_Blue="$(tput setab 4 2>/dev/null || echo '\e[44m')"  # Blue
# On_Purple=$(tput setab 5) # Purple
# On_Cyan=$(tput setab 6)   # Cyan \e[36m
# On_White=$(tput setab 7)  # White

# On_Black='\e[40m'       # Black
# On_Red='\e[41m'         # Red
# On_Green='\e[42m'       # Green
# On_Yellow='\e[43m'      # Yellow
# On_Blue='\e[44m'        # Blue
# On_Purple='\e[45m'      # Purple
# On_Cyan='\e[46m'        # Cyan
# On_White='\e[47m'       # White

# NC='\e[m'               # Color Reset
NC="$(tput sgr 0 2>/dev/null || echo '\e[0m')"             # Color Reset \e[0m

# FancyX='\[\342\]\234\[\227\]'       # ?
# Checkmark='\[\342\]\234\[\223\]'    # ?

PWhite_on_Red='\e[1;39;41m'


case "$TERM" in
  screen*)
    envname="$TERM";;
  *)
    envname=$HOSTNAME;;
esac

set_prompt () {
  local Last_Command=$? # Must come first!
  history -a

  # If it was successful, print a green check mark. Otherwise, print a red X.
  if [[ $Last_Command == 0 ]]; then
    # PS1="\[$BGreen\]$Checkmark "
    PS1=""
  else
    PS1="\[$PWhite_on_Red\]$Last_Command\[$NC\] "
  fi
  
  # If this is an xterm set the title
  case "$TERM" in
    xterm*|rxvt*|screen*)
      PS1+="\[\e]0;${debian_chroot:+($debian_chroot)}\u@$envname: \w\a\]";;
    *)
      ;;
  esac
  
  # Add the hostname
  PS1+="\[$Blue\]${debian_chroot:+($debian_chroot)}$envname \[$BWhite\]\t "
  # If root, just print the host in red. Otherwise, print the current user and host in green.
  if [[ $EUID == 0 ]]; then
    PS1+="\[$PWhite_on_Red\]\\u\[$NC\] \[$Blue\]\\w #\[$NC\] "
  else
    PS1+="\[$Blue\]\\w \\\$\[$NC\] "
  fi
  # Print the working directory and prompt marker in blue, and reset the text color to the default.
  # PS1+="$PBlue\\w \\\$$PNC "
  
}
PROMPT_COMMAND='set_prompt'



alias ..='cd ..'
alias ...='cd ../..'
alias mkdir='mkdir -p'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias cp='cp -p'    # -p : conserve les dates, droits lors de la copie
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"  # Process table searchable / psg bash

#alias df='df -Th --total --sync -l'

#alias  du='du -h'    # Makes a more readable output.
#alias du1='du -h --max-depth=1'
#alias du2='du -h --max-depth=2'
duhelp=$(du --help 2>&1)
duargs='-h'
dusargs='-x'
[[ "$duhelp" == *"max-depth"*  ]] && duargs+=' --max-depth='          || true
[[ "$duhelp" == *"BusyBox"*    ]] && duargs+=' -d '                   || true
[[ "$duhelp" == *"block-size"* ]] && dusargs+=' --block-size=1048576' || true  # Affichage en Mo pour la commande 'dus'
alias  du='\du ${duargs}1'
alias du1='\du ${duargs}1'
alias du2='\du ${duargs}2'
alias dus='\du $dusargs | sort -nr'    # Pour voir quels sont les fichiers volumineux
unset duhelp


#pydf -h >/dev/null 2>&1  # pydf n'existe pas chez 1&1
if has "pydf"; then
  alias df='pydf -h'
fi


alias sudo='sudo '


# Option pour ls :
# -A : affiche aussi les fichiers commençant par un point
# -h : affiche la taille avec B/K/M/G;
# -F : affiche un caractère à la fin du nom indiquant le type de fichier
# -o : affiche les flags, pratique pour détecter les uchg (cf chflags(1))
# -h : pour un lien, change le propriétaire/groupe du lien lui même
alias  l='ls -CF'

# alias ll='ls -AlFh --group-directories-first --time-style="+%d/%m/%Y %H:%M"'
lshelp=$(ls --help 2>&1)
lsargs='-AlFh'
[[ "$lshelp" == *"group-directories-first"* ]] && lsargs+=' --group-directories-first'    || true
[[ "$lshelp" == *"time-style"*              ]] && lsargs+=' --time-style=+%d/%m/%Y_%H:%M' || true
alias ll='ls $lsargs'
unset lshelp

alias la='ls -Ah --group-directories-first'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.
alias lm='ll | more'       #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias tree='tree -CFDshx --dirsfirst --timefmt "%d/%m/%Y %H:%M" --filelimit 200 -I "node_modules|.git"' #  Nice alternative to 'recursive ls' ...


# Pour certaines version d'Ubuntu, l'option -h ("human printing") n'est pas disponible pour la commande "free"
free -h >/dev/null 2>&1
if [ $? == 0 ]; then
  alias free='free -h'
else
  alias free='free -m'
fi


# Remonter d'un dossier et ls
alias d="cd .. && ll"

function u() {
  cd "$1" || exit
  ll
}

alias more='less'
export PAGER=less
export LESSCHARSET='latin1'
export EDITOR=nano

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


set bell-style visible
ulimit -S -c 0      # Don't want coredumps.

shopt -s autocd
shopt -s checkjobs
shopt -s cmdhist
shopt -u mailwarn
unset MAILCHECK

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'"${1:-}"'*' -exec "${2:-file}" {} \;  ; }

#  Find a pattern in a set of files and highlight them (needs a recent version of egrep).
function fstr() {
    OPTIND=1
    local mycase=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
           i) mycase="-i " ;;
           *) echo "$usage"; return ;;
        esac
    done
    shift $(( OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    find . -type f -name "${2:-*}" -print0 | xargs -0 egrep --color=always -sn "${mycase}" "$1" 2>&- | more
}


function swap() { # Swap 2 filenames around, if they exist (from Uzi's bashrc).
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e "$1" ] && echo "swap: $1 does not exist" && return 1
    [ ! -e "$2" ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function extract() {     # Handy Extract Program
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xvjf "$1"     ;;
            *.tar.gz)    tar xvzf "$1"     ;;
            *.bz2)       bunzip2 "$1"      ;;
            *.rar)       unrar x "$1"      ;;
            *.gz)        gunzip "$1"       ;;
            *.tar)       tar xvf "$1"      ;;
            *.tbz2)      tar xvjf "$1"     ;;
            *.tgz)       tar xvzf "$1"     ;;
            *.zip)       unzip "$1"        ;;
            *.Z)         uncompress "$1"   ;;
            *.7z)        7z x "$1"         ;;
            *.lrz)       lrzip -d "$1"     ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}
alias ext=extract


# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar czf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

# Make rights for user and group rw
function fixr() {
  sudo find "$@" -type f -exec chmod u=rwX,g=rwX,o= {} +;
  sudo find "$@" -type d -exec chmod u=rwX,g=rwX,o=rX {} +;
}

function my_ps() { ps "$@" -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }


function killps() {  # kill by process name
  local pid pname sig="-TERM"   # default signal
  if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: killps [-SIGNAL] pattern"
    return;
  fi
  if [ $# = 2 ]; then sig=$1 ; fi
  for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat="${!#}" ); do
    pname=$(my_ps | awk '$1~var { print $5 }' var="$pid" )
    if ask "Kill process $pid <$pname> with signal $sig?"; then
      kill "$sig" "$pid"
    fi
  done
}

function mydf() {       # Pretty-print of 'df' output. Inspired by 'dfc' utility.
  for fs ; do
    if [ ! -d $fs ]
    then
      echo -e $fs" :No such file or directory" ; continue
    fi

    local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
    local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
    local nbstars=$(( 50 * info[1] / info[0] ))
    local out="["
    for ((j=0;j<50;j++)); do
      if [ ${j} -lt ${nbstars} ]; then
        out=$out"*"
      else
        out=$out"-"
      fi
    done
    out=${info[2]}" ""$out""] (""$free"" free on ""$fs"")"
    echo -e "$out"
  done
}


function myips() { # Get IP adresses
  #ifconfig eth1 &>/dev/null
  #if [ "$?" == 0 ]; then
    #MY_IP=$(/sbin/ifconfig eth1 | awk '/inet/ { print $2 } ' | sed -e s/addr:// | sed -e s/adr://)
  #else
    #MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' | sed -e s/addr:// | sed -e s/adr://)
  #fi
  
  #ip addr show scope global | grep "inet " | awk '{ print $2 }' | sed -r ':a;N;$!ba;s/\n/ | /g'
  local ip_list
  
  ip_list="$(hostname -I 2> /dev/null)"
  if [ "$?" != 0 ]; then
    ip_list="$(hostname -i)"
  fi

  # Is there multiple IP separeted by space?
  case "$ip_list" in
    *" "*)
      echo "$ip_list" | xargs | sed -r 's/ / | /g';;
    *)
      echo "$ip_list";;
  esac
}


function ii() {  # Get current host related info.
  local length spaces
  
  [ -r /etc/lsb-release ] && . /etc/lsb-release

  if [ -z "$DISTRIB_DESCRIPTION" ] && [ -x /usr/bin/lsb_release ]; then
    # Fall back to using the very slow lsb_release utility
    DISTRIB_DESCRIPTION=$(lsb_release -s -d)
  fi

  length=${#my_long_name}
  (( length += 6 ))
  # spaces=$(printf ' %.0s' "$(seq 1 $length)")    # Generate spaces
  spaces=$(head -c "$length" < /dev/zero | tr '\0' ' ')

  echo -e "    $On_Blue$spaces$NC  $BBlack$DISTRIB_DESCRIPTION  $(uname -o) $(uname -r) $(uname -m)$NC"
  echo -e "    $White$On_Blue   $my_long_name   $NC  $(date)"
  echo -e "    $On_Blue$spaces$NC  $(myips)"
  
  #echo "" ; uname -a
  # echo -e "${BRed}Current date:$NC    $(date)"
  if has "w"; then
    echo -e "${Yellow}Users logged on:$NC $(w -hs | cut -d ' ' -f1 | sort | uniq)"
  fi
  echo -e "${Yellow}Machine stats:$NC  $(uptime)"
  # echo -e "${BRed}IP Address:$NC      `myips`"
  # echo -e "\n${BRed}Memory stats:$NC "
  echo ""
  free
  # echo -e "\n${BRed}Diskspace:$NC "
  if has "pydf"; then
    echo ""
    pydf -h
  fi
  
  echo ""
}




shopt -s extglob        # Necessary.

complete -A hostname   rsh rcp telnet rlogin ftp ping disk
complete -A export     printenv
complete -A variable   export local readonly unset
complete -A enabled    builtin
complete -A alias      alias unalias
complete -A function   function
complete -A user       su mail finger

complete -A helptopic  help     # Currently same as builtins.
complete -A shopt      shopt
complete -A stopped -P '%' bg
complete -A job -P '%'     fg jobs disown

complete -A directory  mkdir rmdir
complete -A directory   -o default cd

# Compression
complete -f -o default -X '*.+(zip|ZIP)'  zip
complete -f -o default -X '!*.+(zip|ZIP)' unzip
complete -f -o default -X '*.+(z|Z)'      compress
complete -f -o default -X '!*.+(z|Z)'     uncompress
complete -f -o default -X '*.+(gz|GZ)'    gzip
complete -f -o default -X '!*.+(gz|GZ)'   gunzip
complete -f -o default -X '*.+(bz2|BZ2)'  bzip2
complete -f -o default -X '!*.+(bz2|BZ2)' bunzip2
complete -f -o default -X '!*.+(zip|ZIP|z|Z|gz|GZ|bz2|BZ2)' extract


# Documents - Postscript,pdf,dvi.....
complete -f -o default -X '!*.+(ps|PS)'  gs ghostview ps2pdf ps2ascii
complete -f -o default -X '!*.+(dvi|DVI)' dvips dvipdf xdvi dviselect dvitype
complete -f -o default -X '!*.+(pdf|PDF)' acroread pdf2ps
complete -f -o default -X '!*.@(@(?(e)ps|?(E)PS|pdf|PDF)?(.gz|.GZ|.bz2|.BZ2|.Z))' gv ggv
complete -f -o default -X '!*.texi*' makeinfo texi2dvi texi2html texi2pdf
complete -f -o default -X '!*.tex' tex latex slitex
complete -f -o default -X '!*.lyx' lyx
complete -f -o default -X '!*.+(htm*|HTM*)' lynx html2ps
complete -f -o default -X '!*.+(doc|DOC|xls|XLS|ppt|PPT|sx?|SX?|csv|CSV|od?|OD?|ott|OTT)' soffice

# Multimedia
complete -f -o default -X '!*.+(gif|GIF|jp*g|JP*G|bmp|BMP|xpm|XPM|png|PNG)' xv gimp ee gqview
complete -f -o default -X '!*.+(mp3|MP3)' mpg123 mpg321
complete -f -o default -X '!*.+(ogg|OGG)' ogg123
complete -f -o default -X '!*.@(mp[23]|MP[23]|ogg|OGG|wav|WAV|pls|m3u|xm|mod|s[3t]m|it|mtm|ult|flac)' xmms
complete -f -o default -X '!*.@(mp?(e)g|MP?(E)G|wma|avi|AVI|asf|vob|VOB|bin|dat|vcd|ps|pes|fli|viv|rm|ram|yuv|mov|MOV|qt|QT|wmv|mp3|MP3|ogg|OGG|ogm|OGM|mp4|MP4|wav|WAV|asx|ASX)' xine



complete -f -o default -X '!*.pl'  perl perl5


#  This is a 'universal' completion function - it works when commands have a so-called 'long options' mode , ie: 'ls --all' instead of 'ls -a'
#  Needs the '-o' option of grep (try the commented-out version if not available).

#  First, remove '=' from completion word separators (this will allow completions like 'ls --color=auto' to work correctly).

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}


_get_longopts() {
  #$1 --help | sed  -e '/--/!d' -e 's/.*--\([^[:space:].,]*\).*/--\1/'| \
  #grep ^"$2" |sort -u ;
    $1 --help | grep -o -e "--[^[:space:].,]*" | grep -e "$2" |sort -u
}

_longopts() {
  local cur=${COMP_WORDS[COMP_CWORD]}

  case "${cur:-*}" in
   -*)      ;;
    *)      return ;;
  esac

  case "$1" in
   \~*)     eval cmd="$1" ;;
     *)     cmd="$1" ;;
  esac
  COMPREPLY=( $(_get_longopts "${1}" "${cur}" ) )
}
complete  -o default -F _longopts configure bash
complete  -o default -F _longopts wget id info a2ps ls recode

_tar() {
  local cur ext regex tar untar
  local COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}

  # If we want an option, return the possible long options.
  case "$cur" in
    -*) COMPREPLY=( $(_get_longopts "$1" "$cur" ) ); return 0;;
  esac

  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $( compgen -W 'c t x u r d A' -- "$cur" ) )
    return 0
  fi

  case "${COMP_WORDS[1]}" in
    ?(-)c*f)
      COMPREPLY=( $( compgen -f "$cur" ) )
      return 0
      ;;
    +([^Izjy])f)
      ext='tar'
      regex=$ext
      ;;
    *z*f)
      ext='tar.gz'
      regex='t\(ar\.\)\(gz\|Z\)'
      ;;
    *[Ijy]*f)
      ext='t?(ar.)bz?(2)'
      regex='t\(ar\.\)bz2\?'
      ;;
    *)
      COMPREPLY=( $( compgen -f "$cur" ) )
      return 0
      ;;
  esac

  if [[ "$COMP_LINE" == tar*.$ext' '* ]]; then
    # Complete on files in tar file.
    #
    # Get name of tar file from command line.
    tar=$( echo "$COMP_LINE" | sed -e 's|^.* \([^ ]*'$regex'\) .*$|\1|' )
    # Devise how to untar and list it.
    untar=t${COMP_WORDS[1]//[^Izjyf]/}

    COMPREPLY=( $( compgen -W "$( echo $( tar $untar $tar 2>/dev/null ) )" -- "$cur" ) )
    return 0

  else
    # File completion on relevant files.
    COMPREPLY=( $( compgen -G $cur\*.$ext ) )

  fi

  return 0

}

complete -F _tar -o default tar


_killall() {
  local cur
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}

  #  Get a list of processes (the first sed evaluation takes care of swapped out processes, the second takes care of getting the basename of the process).
  COMPREPLY=( $( ps -u "$USER" -o comm  | sed -e '1,1d' -e 's#[]\[]##g' -e 's#^.*/##'| awk '{if ($0 ~ /^'$cur'/) print $0}' ))

  return 0
}

complete -F _killall killall killps


ii


unset color_prompt force_color_prompt



# Cloud rules
has "az"    && echo -e "Azure-CLI (python) is installed\n" && [ -f $HOME/lib/azure-cli/az.completion ] && source $HOME/lib/azure-cli/az.completion || true
has "azure" && eval $(azure --completion) && echo -e "Azure-CLI (nodeJS) is installed\n" || true
has "aws"   && echo -e "AWS-CLI (python) is installed\n" || true

# Travi-CI
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh || true


