%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    Erliza Utility Module
%%% @end
%%% Created : 28 Jan 2019 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(erliza_utils).

-include("erliza.hrl").

%% API
-export([parse_opts/1, get_opts/2, string_to_term/1]).

%%%===================================================================
%%% API
%%%===================================================================

parse_opts(Opts) ->
    parse_opts(Opts, #{}).

parse_opts([], Acc) -> Acc;
parse_opts([{noinput, V}|T], Acc) ->
    parse_opts(T, Acc#{noinput => V});
parse_opts([{remote_node, V}|T], Acc) ->
    parse_opts(T, Acc#{remote_node => V});
parse_opts([{local_node, V}|T], Acc) ->
    parse_opts(T, Acc#{local_node => V});
parse_opts([{cookie, V}|T], Acc) ->
    parse_opts(T, Acc#{cookie => V});
parse_opts([{comment, V}|T], Acc) ->
    parse_opts(T, Acc#{comment => V});
parse_opts([{erliza_app, V}|T], Acc) when is_atom(V) ->
    parse_opts(T, Acc#{erliza_app => V});
parse_opts([H|T], Acc) ->
    io:format("WARNING - unknown option ~p~n", [H]),
    parse_opts(T, Acc).

get_opts(noinput, State) ->
    maps:get(noinput, State, false);
get_opts(erliza_app, State) ->
    maps:get(erliza_app, State, ?DEFAULT_ERLIZA_APP);
get_opts(cookie, State) ->
    maps:get(cookie, State, ?DEFAULT_COOKIE);
get_opts(comment, State) ->
    maps:get(comment, State, undefined);
get_opts(remote_node, State) ->
    maps:get(remote_node, State, undefined);
get_opts(local_node, State) ->
    maps:get(local_node, State, ?DEFAULT_LOCAL_NODE).

string_to_term([]) -> [];
string_to_term(TermStr) when is_list(TermStr) ->
    S = case lists:reverse(TermStr) of 
            [$.|_] ->
                TermStr;
            _ ->
                make_terminal(TermStr)
        end,
    {ok, Terms, _ } = erl_scan:string(S),
    {ok, T} = erl_parse:parse_term(Terms),
    T.


%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

%%%===================================================================
%%% Internal functions
%%%===================================================================

make_terminal(S) when is_list(S) -> S ++ ".".
