######
#
# For building 'project'
#
######

CC=gcc
SED=sed
RMF=rm -f

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######
#
CFLAGS=
#
# CFLAGS=-g
# CFLAGS=-g -O
# CFLAGS=-g -O2
#
GCFLAG=
GCFLAG=-DATS_MEMALLOC_LIBC
# GCFLAG=-DATS_MEMALLOC_GCBDW
#
LIBGC=
# LIBGC=-lgc
#
######

SRCSATS := \
project.sats
SRCDATS := \
project.dats \
project_trans.dats \
project_t1ype.dats \
project_t1erm.dats \

######

OBJSATS := \
$(patsubst %.sats, BUILD/%_sats.o, $(SRCSATS))
OBJDATS := \
$(patsubst %.dats, BUILD/%_dats.o, $(SRCDATS))

######
#
INCLUDE:=
INCLUDE+=-I"."
INCLUDE+=-I"./../../Xanadu/srcgen1"
#
######
LIBRARY:=-L"./../../Xanadu/lib" -lxatsopt
######
#
all: \
project
project: \
$(OBJSATS) $(OBJDATS) ; \
$(PATSCC) -o project \
$(INCLUDE) $(GCFLAG) $^ $(LIBGC) $(LIBRARY)
#
######

BUILD/%_sats.c: \
./%.sats ; $(PATSOPT) -o $@ --static $<
BUILD/%_dats.c: \
./%.dats ; $(PATSOPT) -o $@ --dynamic $<

######

BUILD/%_sats.o: \
BUILD/%_sats.c; \
$(PATSCC) $(INCLUDE) $(CFLAGS) -o $@ -c $<
BUILD/%_dats.o: \
BUILD/%_dats.c; \
$(PATSCC) $(INCLUDE) $(CFLAGS) $(GCFLAG) -o $@ -c $<

######

clean:: ; $(RMF) BUILD/*_?ats.c
clean:: ; $(RMF) BUILD/*_?ats.o
clean:: ; $(RMF) project_dats.o
clean:: ; $(RMF) project_dats.c
clean:: ; $(RMF) project_dats.c

######

cleanall:: clean; $(RMF) project

######

libxatsopt:: ; \
(cd ./../../Xanadu/srcgen1 && make libxatsopt && make clean)

######

###### end of [Makefile] ######
