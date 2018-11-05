python3 -m site &> /dev/null && PATH="$PATH:`python3 -m site --user-base`/bin" || :
python2 -m site &> /dev/null && PATH="$PATH:`python2 -m site --user-base`/bin" || :
