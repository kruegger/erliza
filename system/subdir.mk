###-*-makefile-*-
ifeq ($(SUBDIRS),)
SUBDIRS = c_src src priv test
endif

all:
	@set -e ; \
	  for d in $(SUBDIRS) ; do \
	    if [ -f $$d/Makefile ]; then ( cd $$d && $(MAKE) ) || exit 1 ; fi ; \
	done

clean:
	@for d in $(SUBDIRS) ; do \
	  if [ -f $$d/Makefile ]; then ( cd $$d && $(MAKE) clean ) fi ; \
	done
