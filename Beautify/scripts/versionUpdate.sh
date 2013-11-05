#!/bin/bash
echo "Updating 'BEAUTIFY_VERSION_NUMBER'..."

echo "Version is" $1

sed -i '' -e 's/#define BEAUTIFY_VERSION_NUMBER .*/#define BEAUTIFY_VERSION_NUMBER "'"$1"'"/' Beautify/BYBeautifyVersion.h