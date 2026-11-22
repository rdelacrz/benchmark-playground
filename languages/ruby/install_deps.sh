#!/bin/bash
set -e

cd "$(dirname "$0")"
bundle config set --local path vendor/bundle
bundle install
