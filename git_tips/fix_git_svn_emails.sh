#!/bin/sh


# Retroactively Correct Authors with Git SVN?
# https://stackoverflow.com/questions/392332/retroactively-correct-authors-with-git-svn

# Just put this on the root of your git repository and run it: ./fix_git_svn_emails.sh

git filter-branch --env-filter '

n=$GIT_AUTHOR_NAME
m=$GIT_AUTHOR_EMAIL

case ${GIT_AUTHOR_NAME} in
        username) n="username" ; m="username@hotmail.com" ;;
        "User Two") n="User Two" ; m="user2@example.com" ;;
esac

export GIT_AUTHOR_NAME="$n"
export GIT_AUTHOR_EMAIL="$m"
export GIT_COMMITTER_NAME="$n"
export GIT_COMMITTER_EMAIL="$m"
'
