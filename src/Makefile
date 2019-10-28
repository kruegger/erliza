include ../system/include.mk

include ../vsn.mk
VSN=$(ERLIZA_VSN)

MODULES=erliza_leex	\
	erliza_yecc	\
	erliza_utils    \
	erliza_rule	\
	erliza

ERLIZA_APP_RULE_MODULES=erliza_script

ERLIZA_APP_MODULES=$(ERLIZA_APP_RULE_MODULES) \
		erliza_sample

ERLIZA_APP_EBIN_FILES=$(ERLIZA_APP_MODULES:%=../ebin/%.$(EMULATOR))
ERLIZA_APP_RULE_TMPL=$(ERLIZA_APP_RULE_MODULES:%=%.erl.tpl)

EBIN_FILES=$(MODULES:%=../ebin/%.$(EMULATOR)) ../ebin/erliza.app
ERLC_FLAGS+=-I../../ -I../include

ERLIZAC=$(ERL) -noinput -pa ../../erliza/ebin $(ERLIZA_APP_PATH) -run erliza_rule preprocess

ERLIZA_APP_PATH=
ERLIZAC_FLAGS='[{local_node, "hmx-mml@127.0.0.1"},\
	 	  {cookie, "hmx-os"},\
	 	  {erliza_app, erliza_script},\
	 	  {noinput, true},\
	 	  {comment, "HEADER"}]'

#
# Targets
#

all: erliza_leex.erl erliza_yecc.erl $(EBIN_FILES)

debug:
	$(MAKE) ERLC_FLAGS+="$(ERLC_FLAGS) +debug_info -Ddebug"

rule: $(ERLIZA_APP_RULE_TMPL)

app: $(ERLIZA_APP_EBIN_FILES)

clean:
	rm -f ../ebin/*
	rm -f erliza_leex.erl
	rm -f erliza_yecc.erl
	rm -f $(ERLIZA_APP_RULE_TMPL)

erliza_leex.erl:
	$(ERLC) erliza_leex.xrl

erliza_yecc.erl:
	$(ERLC) erliza_yecc.yrl

erliza_script.erl.tpl: ../priv/eliza.script
	$(ERLIZAC) $< $(ERLIZAC_FLAGS)
