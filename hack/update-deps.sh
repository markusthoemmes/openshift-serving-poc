#!/bin/bash

serving_dir="vendor/github.com/knative/serving"
serving_branch="release-0.4"

# Checkout upstream version
rm -rf $serving_dir
git clone --depth 1 --branch $serving_branch https://github.com/knative/serving.git $serving_dir
rm -rf $serving_dir/.git

# Apply all patches
patch -p1 < vendor-patches/*.patch
