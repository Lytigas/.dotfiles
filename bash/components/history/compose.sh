#!/usr/bin/env bash
set -e

echo '# See bash(1) for more'
echo '# do not put duplicate lines or lines starting with space in the history.'
echo 'HISTCONTROL=ignoreboth'
echo 'shopt -s histappend'
echo 'HISTSIZE=1000'
echo 'HISTFILESIZE=2000'
