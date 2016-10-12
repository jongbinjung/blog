#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

git log --pretty=format:"%s" --since="$(cat last_deploy)" > blog.jongbin.com/upstream_commits
date +"%F %T" > last_deploy

# Build the project.
hugo -d blog.jongbin.com  # if using a theme, replace by `hugo -t <yourtheme>`

# Go To Public folder
cd blog.jongbin.com
# Add changes to git.
git add -A

# Commit changes.
msg="Rebuild site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg" -m "$(cat upstream_commits)"

# Push source and build repos.
git push origin master

# Come Back
cd ..
#rsync -rlpdoDz --force --delete --progress -e "ssh -p22" public/ jongbin@jongbin.com:/home/jongbin/www/blog
