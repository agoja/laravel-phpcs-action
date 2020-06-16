#!/bin/sh

cp /action/problem-matcher.json /github/workflow/problem-matcher.json

echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/problem-matcher.json"

echo "Review Laravel standards"
changed_files=$(git diff @~..@ --name-only --diff-filter=d --pretty="format:" -- . ":(exclude,glob)html");
echo -e "These are committed files for phpcs review:\n$changed_files";
files_formatted="$(echo $changed_files | sed 's/ / .\//g')";
phpcs --config-show
phpcs --report=checkstyle --ignore=.md,.xml,.js,.css,artisan,.png,.svg,.woff2,.woff,.ttf,.eot,*/Migrations/*,*blade.php --encoding=utf-8 -p --extensions=php "./"$files_formatted

status=$?

echo "::remove-matcher owner=phpcs::"

exit $status
