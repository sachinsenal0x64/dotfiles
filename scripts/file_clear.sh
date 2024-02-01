#!/bin/sh

find -type f -exec sudo mv -vb -- {} . \;
find . -type d -empty -print
find . -type d -empty -delete
