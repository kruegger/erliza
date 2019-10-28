
###-*-makefile-*-   ; force emacs to enter makefile-mode

ifndef INCLUDE_MK

OTP_ROOT=/usr/lib/erlang
ERL=$(OTP_ROOT)/bin/erl
ERLC=$(OTP_ROOT)/bin/erlc

EMULATOR=beam

ERLC_FLAGS=

ifneq ($(and $(MAJOR),$(MINOR),$(SERVICE_PACK),$(PATCH)),)
HMX_SYSTEM_VSN=$(MAJOR).$(MINOR).$(SERVICE_PACK).$(PATCH)$(SERIALNO)
else
MAJOR=0
MINOR=1
SERVICE_PACK=0
PATCH=0
SERIALNO=0
# SERIALNO should contain delimiter but below is an exception with '.' prefix. 
HMX_SYSTEM_VSN=$(MAJOR).$(MINOR).$(SERVICE_PACK).$(PATCH).$(SERIALNO)
endif

SYS_APP_VSN=$(HMX_SYSTEM_VSN)


INSTALL=/usr/bin/install -c
INSTALL_DATA=${INSTALL} -m 644
INSTALL_EXE=${INSTALL} -m 755
INSTALL_SECRET=${INSTALL} -m 400

APPSCRIPT = '$$vsn=shift; $$mods=""; while(@ARGV){ $$_=shift; s/^([A-Z].*)$$/\'\''$$1\'\''/; $$mods.=", " if $$mods; $$mods .= $$_; } while(<>) { s/%VSN%/$$vsn/; s/%MODULES%/$$mods/; print; }'

EMMLC=$(ERL) -noinput -pa ../../emml/ebin $(EMML_APP_PATH) -run emml_gen start

ERLIZAC=$(ERL) -noinput -pa ../../erliza/ebin $(ERLIZA_APP_PATH) -run erliza_rule preprocess


# Targets

../ebin/%.app: %.app.src ../vsn.mk Makefile
	perl -e $(APPSCRIPT) "$(VSN)" $(MODULES) < $< > $@

../ebin/%.appup: %.appup 
	cp $< $@

../ebin/%.$(EMULATOR): %.erl
	$(ERLC) -b$(EMULATOR) $(ERLC_FLAGS) -o ../ebin $<

%.$(EMULATOR): %.erl
	$(ERLC) -b$(EMULATOR) $(ERLC_FLAGS) $<

%.obj:	%.c
	$(CC) $(CFLAGS) -c $<

%.o:	%.c
	$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -c $<

%.o:	%.cpp
	$(CPP) $(CFLAGS) $(DEFINES) $(INCLUDES) -c $<

%.yecc:
	$(ERLC) $(CFLAGS) $(DEFINES) $(INCLUDES) $@

%.xrl:
	$(ERLC) $(INCLUDES) $@

../priv/%.escript: %.escript.src
	install -m 755 $< ../priv/$(basename $@)

%.escript.src: ../doc/%.mml
	$(EMMLC) $< $(EMMLC_FLAGS)

endif
