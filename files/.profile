# If not running interactively, don't do anything
[ -z "$PS1" ] && return



# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth:erasedups

# Ignore list for history
HISTIGNORE="&:[bf]g:clear:fg:ll:h:ls"

# If the HISTTIMEFORMAT is set, the time stamp information associated with each history entry is written to the history file, marked with the history comment character.
HISTTIMEFORMAT="%d/%m/%y %T "

# Set history length
HISTSIZE=10000
HISTFILESIZE=40000

# Time format for bash command "time"
TIMEFORMAT=$'\n  %2lR\tuser  %2lU\tsys  %2lS\tpcpu %P\n'

# Time format for GNU command "/usr/bin/time"
TIME="\nTime taken: %E  \nCPU total: %P   CPU system: %Ss   CPU user: %Us\nMemory avg: %k Kb   Memory max:  %M Kb"
alias time='/usr/bin/time'

# append to the history file, don't overwrite it
shopt -s histappend

# Default file permissions
umask u=rwx,g=rx,o=

# check the window size after each command and, if necessary,  update the values of LINES and COLUMNS.
shopt -s checkwinsize

# ls case insensitive patterns (x and X is the same for ls)
shopt -s nocaseglob

# If set, the pattern "**" used in a pathname expansion context will match all files and zero or more directories and subdirectories.
#shopt -s globstar

# If set, Bash includes filenames beginning with a '.' in the results of filename expansion.
shopt -s dotglob

shopt -s autocd
shopt -s checkjobs
shopt -s cmdhist
shopt -u mailwarn
shopt -s extglob
unset MAILCHECK


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  # test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi


# Test if -h option for free exists
free -h >/dev/null 2>&1
if [ $? == 0 ]; then
  alias free='free -h'
else
  alias free='free -m'
fi



alias ls='ls --color=auto'
alias ll='ls -AlFh'
alias grep='grep --color=auto'
alias du='du -h'
alias du1='du -h -d 1'
alias free='free -m'
alias df='df -h'

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\u@`hostname`\[\033[01;32m\] \t \[\033[01;33m\]\w\[\033[00m\] \$ '
EDITOR=nano




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


