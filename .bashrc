SCRIPTPATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTRA_BASHRC=$SCRIPTPATH/.bashrc_$(hostname)

p() {
  status=$(git status)

  if [[ ${status} == *"Changes to be committed"* ]] ||
    [[ ${status} == *"Changes not staged for commit"* ]] ||
    [[ ${status} == *"Changes to be committed"* ]]; then
    git stash -u
    git pull
    git fetch --prune && git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d 2>/dev/null
    git stash pop
  else
    git pull
    git fetch --prune && git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d 2>/dev/null
  fi
}

g() {
  if [[ $# -eq 0 ]]; then
    git status
  else
    git $@
  fi
}

b() {
  if [[ -f ./mvnw ]]; then
    ./mvnw clean install
  else
   ./gradlew clean build
  fi
}

c() {
  if [[ $# -eq 0 ]]; then
    cd ${PROJECT_PATH}
  elif [[ $1 == "." ]]; then
    git commit .
  else
    cd ${PROJECT_PATH}/$1
  fi
}

reset() {
  git status 2>/dev/null >/dev/null && git reset $@ || /usr/bin/reset $@
}

rebase() {
  git status 2>/dev/null >/dev/null && git rebase $@ || /usr/bin/rebase $@
}

diff() {
  git status 2>/dev/null >/dev/null && git diff $@ || /usr/bin/diff $@
}

create-branch() {
  git checkout -b $1
  git push -u origin $1
}

delete-branch() {
  git branch -d $1
  git push origin --delete $1
}

function pull-master() {
  git fetch origin
  git merge origin/master
}

alias gradlew=./gradlew
alias mvnw=./mvnw
alias r=git\ reset\ --hard\ HEAD

alias init=git\ init
alias clone=git\ clone
alias add=git\ add
alias log=git\ log
alias show=git\ show
alias branch=git\ branch
alias checkout=git\ checkout
alias commit=git\ commit
alias merge=git\ merge
alias tag=git\ tag
alias fetch=git\ fetch
alias pull=git\ pull
alias push=git\ push
alias status=git\ status
alias stash=git\ stash
alias ggrep=git\ grep
alias show-branch=git\ show-branch
alias master=git\ checkout\ master
alias revert=git\ revert

alias .scp=scp\ -oStrictHostKeyChecking=no\ -oUserKnownHostsFile=/dev/null
alias .ssh=ssh\ -oStrictHostKeyChecking=no\ -oUserKnownHostsFile=/dev/null


alias l=ls
alias la=ls\ -a
alias lla=ls\ -la

## a quick way to get out of current directory ##
alias ..=cd\ .. 
alias .2=cd\ ../..
alias .3=cd\ ../../..
alias .4=cd\ ../../../..
alias .5=cd\ ../../../../..

## Colorize the grep command output for ease of use (good for log files)##
alias grep=grep\ --color=auto
alias egrep=egrep\ --color=auto
alias fgrep=fgrep\ --color=auto

# handy short cuts #
alias h=history
alias j=jobs\ -l

alias ports=netstat\ -tulanp

if [[ -f $EXTRA_BASHRC ]]; then
  . $EXTRA_BASHRC
fi

export PATH=$PATH:$HOME/bin
