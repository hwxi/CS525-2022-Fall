######
#
# Makefile]
#
#######

test:: lambda2; ./lambda2

######

lambda2: \
lambda2.dats; \
patscc -DATS_MEMALLOC_LIBC -o $@ $<

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.c
cleanall:: clean
cleanall:: ; rm -f lambda2

############ end of [Makefile] ############
