#!/bin/bash

BRANCH=${1:-master}

serving_dir="vendor/github.com/knative/serving"

echo "Cloning '$BRANCH' branch of knative/serving"
rm -rf $serving_dir
git clone --depth 1 --branch "$BRANCH" https://github.com/knative/serving.git $serving_dir
rm -rf $serving_dir/.git

echo "Applying patches"
patch -p1 < vendor-patches/*.patch
