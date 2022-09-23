test:: lambda0; ./lambda0
lambda0: lambda0.dats; \
patscc -DATS_MEMALLOC_LIBC -o $@ $<
clean:: ; rm -f *~
clean:: ; rm -f *_dats.c
cleanall:: clean
cleanall:: ; rm -f lambda0
