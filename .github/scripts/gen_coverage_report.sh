#!/bin/bash

set -eu

go test -race -covermode atomic -coverprofile=cover.out ./... && go tool cover -html=cover.out -o cover.html

git config --global user.name tomoyane
git config --global user.email "${UPPY_DRIVER_EMAIL}"
git remote set-url --push origin https://tomoyane:"${GITHUB_TOKEN}"@github.com/tomoyane/http-continuous-benchmarking.git
git remote -v

git fetch
git checkout coverage
git add --force cover.html
git commit -m "[ci skip] Update coverage"
git remote set-url --push origin https://tomoyane:${GITHUB_TOKEN}@github.com/tomoyane/http-continuous-benchmarking.git
git push origin HEAD:coverage --force