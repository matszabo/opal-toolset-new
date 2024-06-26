all: rng discovery control

CC=gcc
CFLAGS=-g -O0 -Wall

GIT_VERSION := $(shell git rev-parse --short=16 HEAD 2>/dev/null)

# utils
rng: common.o utils.o rng.c
	$(CC) $(CFLAGS) rng.c common.o utils.o -o rng

discovery: common.o utils.o discovery.c
	$(CC) $(CFLAGS) discovery.c common.o utils.o -o discovery -ludev -DGIT_VERSION=$(GIT_VERSION)

control: common.o utils.o control.c
	$(CC) $(CFLAGS) control.c common.o utils.o -o control

# library
common.o: common.c common.h
	$(CC) $(CFLAGS) -c common.c

utils.o: utils.c utils.h
	$(CC) $(CFLAGS) -c utils.c

# misc
clean:
	rm -f common.o utils.o rng discovery control rng.o discovery.o control.o
