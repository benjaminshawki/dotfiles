#!/bin/bash

# Use find to search for files within directories recursively, EXcluding the script file itself and the dotfiles,
# and then use grep to search within those files.
find . -type f ! -name 'current-root-domain-deployment.sh' ! -name '.*' -exec grep -l 'Host(`bluejund.com`)' {} +
