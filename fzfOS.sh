#!/usr/bin/env bash
# fzfOS version 0.0001

alias app='find /Applications ~/Applications -type d -iregex ".*.app$" -prune | fzf | sed '"'s/ /\\\\ /'"'| xargs open'
#alias play='cat ~/bin/spotifyplaylists.txt | fzf | cut -d " " -f 1,1 - | xargs open -a Spotify'
alias play='cat ~/bin/spotifyplaylists-applescript.txt | fzf | osascript '

alias openapps='ps aux | grep "/Applications.*.app/" | sed -n '"'s/.*\(\/Applications.*.app\)\/.*/\1/p'"' | sort -u | fzf | sed '"'s/ /\\\\ /'"' | xargs open'
alias choosechrometab='chromeopentabs | fzf | xargs chromesettab'
#alias findfiles='mdfind ~ | fzf --bind "space:execute(qlmanage -p {})" | xargs open'
alias findfiles='find ~ -name ".*" -prune -o -print | fzf --bind "space:execute(qlmanage -p {})" | xargs open'

# "cd" script for z.sh and fzf fuzzy finding
c() {
   if [ -z "$1" ]; then
      dir=$(z | awk '{print $2}' | fzf +m) &&
      cd "$dir"
   else
      dir=$(z | grep $1 | awk '{print $2}' | fzf +m) &&
      cd "$dir"
   fi;
}

# selector script for different typed launchers.
# Used with iTerm's Hotkey Window as a replacement for spotlight
s() {
  echo <<EOF "
    Select a launcher type:
      a => Apps
      c => choose Chrome tab
      f => Find Files in ~
      o => Switch between Open Apps
      p => spotify Playlists
"
EOF
  read type
  case "$type" in
    a)
      app
      clear
      s
      ;;

    c)
      choosechrometab
      clear
      s
      ;;

    f)
      findfiles
      clear
      s
      ;;

    o)
      openapps
      clear
      s
      ;;

    p)
      play
      clear
      s
      ;;

    *)
      exit 1
  esac
}

