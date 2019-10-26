%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    Eliza Sample Code
%%% @end
%%% Created : 25 Jan 2019 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(erliza_sample).

%% API
-compile([export_all]).

%%%===================================================================
%%% API
%%%===================================================================

talking(App) ->
    OpeningComment = erliza:opening(App),
    write_words(OpeningComment), 
    talking_loop(App).

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

-define(ERLIZA_PROMPT, " ERLIZA : ~s~n").
-define(MY_PROMPT,    "   ME  : ").
 

%% input and output functions
write_words(WordLs) ->
    io:format(?ERLIZA_PROMPT,[string:join(WordLs, " ")]).

read() ->
    io:get_line(?MY_PROMPT).

talking_loop(App) ->
    Sentence = read(),
    Dialog = erliza:dialog(Sentence),
    case erliza:is_quit(Dialog, App) of
        true -> 
            ClosingComment = erliza:closing(App),
            write_words(ClosingComment),
            halt();
        false ->
            Response =  erliza:response(Dialog, App),
            write_words(Response),
            talking_loop(App)
    end.

%%%===================================================================
%%% Internal functions
%%%===================================================================

