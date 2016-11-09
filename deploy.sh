#!/bin/bash -eu
rm -rf public && cp -r docs public
cd public
rm -rf *.sh .travis .travis.yml package.json
git init
git add .
git commit -m "Publishing site on `date "+%Y-%m-%d %H:%M:%S"`"
git push -f git@github.com:okwrtdsh/study_test.git master:gh-pages

