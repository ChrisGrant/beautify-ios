#!/bin/bash
sed -i '' -e 's/#define BEAUTIFY_VERSION_NUMBER .*/#define BEAUTIFY_VERSION_NUMBER "'"$1"'"/' Beautify/BYBeautifyVersion.h