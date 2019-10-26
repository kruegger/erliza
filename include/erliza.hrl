%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    Erliza Header file
%%% @end
%%% Created : 28 Jan 2019 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------

-record(script,{value}).
-record(initial, {init_word_list}).
-record(final, {final_word_list}).
-record(quit, {quit_word_list}).
-record(pre, {orig_word, replace_word_list}).
-record(post, {orig_word, replace_word_list}).
-record(synon, {sample, synon_list}).
-record(key, {keyword, priority, decomp_list}).
-record(decomp, {pattern, reasmb_index, reasmb_list}).
-record(reasmb, {rule, value}).

-define(ERLIZA_SCRIPT_EXT, ".script").
-define(ERLIZA_RULE_CODE_EXT, ".erl.tpl").
-define(XNONE, "xnone").
-define(VAR, "\([0-9]\)").
-define(OPTIONS, [{capture, all_but_first, list}]).
-define(SEP, " ,\n").
-define(DEFAULT_ERLIZA_APP, erliza_script).
-define(DEFAULT_ERLIZA_APP_PATH, "../ebin/").
-define(DEFAULT_COOKIE, "yummy").
-define(DEFAULT_LOCAL_NODE, "erliza@127.0.0.1").
-define(DEFAULT_HEADER, "HEADER").
