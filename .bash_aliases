function __gitstashpullstashpop() {
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

function __gitStatusOrGit() {
  if [[ $# -eq 0 ]]; then
    git status
  else
    git $@
  fi
}

function __contextual_rm() {
  git rm -f $@ 2>/dev/null || /bin/rm -f $@
}

function __contextual_mv() {
  git mv -f $@ 2>/dev/null || /bin/mv -f $@
}

function __contextual_reset() {
  git status 2>/dev/null >/dev/null && git reset $@ || /usr/bin/reset $@
}

function __contextual_rebase() {
  git status 2>/dev/null >/dev/null && git rebase $@ || /usr/bin/rebase $@
}

function __contextual_diff() {
  git status 2>/dev/null >/dev/null && git diff $@ || /usr/bin/diff $@
}

function __contextual_c() {
  if [[ $# -eq 0 ]]; then
    cd ${PROJECT_PATH}
  elif [[ $1 == "." ]]; then
    git commit .
  else
    git checkout $@
  fi
}

function git_create_branch() {
  git checkout -b $1
  git push -u origin $1
}

function git_delete_branch() {
  git branch -d $1
  git push origin --delete $1
}

function git_pull_master() {
  git fetch origin
  git merge origin/master
}

function __contextual_build_mgr() {
   if [[ -f ./mvnw ]]; then
    ./mvnw $@
  elif [[ -f ./gradlew ]]; then
    ./gradlew $@
  elif [[ -f ./package.json ]]; then
    npm $@
  fi
}

function __contextual_build() {
  if [[ -f ./mvnw ]]; then
    ./mvnw clean install
  else
   ./gradlew clean build
  fi
}

alias gradlew=./gradlew
alias mvnw=./mvnw
alias g=__gitStatusOrGit
alias p=__gitstashpullstashpop
alias c=__contextual_c
alias b=__contextual_build
alias r=git\ reset\ --hard\ HEAD

alias init=git\ init
alias clone=git\ clone
alias add=git\ add
alias reset=__contextual_reset
alias rm=__contextual_rm
alias mv=__contextual_mv
alias log=git\ log
alias show=git\ show
alias branch=git\ branch
alias checkout=git\ checkout
alias commit=git\ commit
alias diff=__contextual_diff
alias merge=git\ merge
alias rebase=__contextual_rebase
alias tag=git\ tag
alias fetch=git\ fetch
alias pull=git\ pull
alias push=git\ push
alias status=git\ status
alias stash=git\ stash
alias ggrep=git\ grep
alias show-branch=git\ show-branch
alias master=git\ checkout\ master
alias create-branch=git_create_branch
alias delete-branch=git_delete_branch
alias pm=git_pull_master
alias revert=git\ revert

export COMMON_PEM_PATH=~/.ssh/blei.pem
alias .scp=scp\ -i\ "${COMMON_PEM_PATH}"
alias .ssh=ssh\ -i\ "${COMMON_PEM_PATH}"
alias @=__contextual_build_mgr
