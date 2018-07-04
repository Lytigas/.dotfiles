#!/usr/bin/env bash
set -e

echo '# Exit if shell is non-interactive'
echo 'case $- in'
echo '    *i*) ;;'
echo '      *) return;;'
echo 'esac'
