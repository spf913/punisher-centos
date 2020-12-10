#!/usr/bin/env sh

#Fix the link that S6 Overlay blew away
if [ ! -L "/bin" ]; then
  cd / || exit 1
  tar cf - bin | ( cd /usr || exit 1; tar xfp - )
  rm -f -- bin/*
  rmdir bin
  ln -s /usr/bin bin
fi
