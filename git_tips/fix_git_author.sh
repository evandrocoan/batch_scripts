#!/bin/sh





# https://help.github.com/articles/changing-author-info/


# Open Git Bash.

# Create a fresh, bare clone of your repository:

# git clone --bare https://github.com/user/repo.git
# cd repo.git
# Copy and paste the script, replacing the following variables based on the information you gathered:

# OLD_EMAIL
# CORRECT_NAME
# CORRECT_EMAIL

# #!/bin/sh

# git filter-branch --env-filter '
# OLD_EMAIL="your-old-email@example.com"
# CORRECT_NAME="Your Correct Name"
# CORRECT_EMAIL="your-correct-email@example.com"
# if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
# then
#     export GIT_COMMITTER_NAME="$CORRECT_NAME"
#     export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
# fi
# if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
# then
#     export GIT_AUTHOR_NAME="$CORRECT_NAME"
#     export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
# fi
# ' --tag-name-filter cat -- --branches --tags
# view rawgit-author-rewrite.sh hosted with ❤ by GitHub
# Press Enter to run the script.
# Review the new Git history for errors.
# Push the corrected history to GitHub:

# git push --force --tags origin 'refs/heads/*'
# Clean up the temporary clone:

# cd ..
# rm -rf repo.git



git filter-branch --env-filter '
OLD_EMAIL="addons_zz@outlook.com"
CORRECT_NAME="username"
CORRECT_EMAIL="username@hotmail.com"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags

