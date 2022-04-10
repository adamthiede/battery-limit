#!/usr/bin/env bash
ifndef PREFIX
  PREFIX = /usr/
endif
DESTDIR=${PREFIX}

default:
	shellcheck

clean:
	rm -f launcher

