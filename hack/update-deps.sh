#!/bin/bash

set -e

BRANCH=${1:-master}

serving_dir="vendor/github.com/knative/serving"

echo "Cloning '$BRANCH' branch of knative/serving..."
rm -rf $serving_dir
git clone --depth 1 --branch "$BRANCH" https://github.com/knative/serving.git $serving_dir
rm -rf $serving_dir/.git

current_commit=$(cd "$serving_dir" || exit; git rev-parse HEAD)
echo "Checked out '$current_commit' ($BRANCH)."

echo "Applying patches..."
patch -p1 < vendor-patches/*.patch
