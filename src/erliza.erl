%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    Erliza Main
%%% @end
%%% Created : 29 Jan 2019 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(erliza).

-include("erliza.hrl").

%% API
-export([response/2, is_quit/2, dialog/1, opening/1, closing/1]).

%%%===================================================================
%%% API
%%%===================================================================

response(Dialog, App) ->
    SortedKeys = prioritize(Dialog, App),
    PreprocessDialog = preprocess(Dialog, App),
    Response = process(PreprocessDialog, SortedKeys, App),
    Response.

is_quit([], _App) -> false;
is_quit([H|T], App) ->
    case App:quit(H) of
        true -> true;
        _ -> is_quit(T, App)
    end.

dialog(Input) when is_list(Input) -> string:tokens(Input, ?SEP).

opening(App) -> App:initial().

closing(App) -> App:final().

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

%%%===================================================================
%%% Internal functions
%%%===================================================================

prioritize([], _) -> [];
prioritize([H|_] = Words, App) when is_atom(App) ->
    Keys = prioritize(Words, App:key(H), App),
    lists:sort(fun({_, PriA}, {_, PriB}) -> PriA > PriB end, Keys).

prioritize([_|[]], [], _App) -> [];
prioritize([H|[]], {Priority, _}, _App) -> 
    [{H, Priority}];
prioritize([_, H|T], [], App) ->
    prioritize([H|T], App:key(H), App);
prioritize([H1, H2|T], {Priority, _}, App) ->
    [{H1, Priority}|prioritize([H2|T], App:key(H2), App)].
    
preprocess([], _) -> [];
preprocess([H|_] = Words, App) when is_atom(App) ->
    preprocess(Words, App:pre(H), App).
preprocess([H|[]], [], _App) -> [H];
preprocess([_|[]], [Match], _App) -> [Match];
preprocess([H1, H2|T], [], App) ->
    [H1|preprocess([H2|T], App:pre(H2), App)];
preprocess([_, H|T], [Match], App) when is_list(Match) ->
    [Match|preprocess([H|T], App:pre(H), App)].
                       
process(Dialog, Keys, App) ->
    case key_match(Keys, Dialog, App) of
        [] ->
            key_match([{?XNONE, 0}], Dialog, App);
        Response -> Response
    end.

key_match([], _, _) -> [];
key_match([{Key, _}|T], Dialog, App) ->
    {_, Decomps} = App:key(Key),
    key_match(T, decomposition_rule(Decomps, Dialog, App), Dialog, App).
key_match(_, {match, NewWords}, _, _) -> NewWords;
key_match(_, {goto, GotoKey}, Dialog, App) -> key_match([{GotoKey, 0}], Dialog, App);
key_match(T, nomatch, Dialog, App) -> key_match(T, Dialog, App).

postprocess([], _) -> [];
postprocess([H|_] = Words, App) when is_atom(App) ->
    postprocess(Words, App:pre(H), App).
postprocess([H|[]], [], _App) -> [H];
postprocess([_|[]], [Match], _App) -> [Match];
postprocess([H1, H2|T], [], App) ->
    [H1|postprocess([H2|T], App:post(H2), App)];
postprocess([_, H|T], [Match], App) when is_list(Match) ->
    [Match|postprocess([H|T], App:post(H), App)].

decomposition_rule([], _Dialog, _App) -> nomatch;
decomposition_rule([#decomp{pattern = PatternWords, 
                            reasmb_list = Reasmbs}|T], Dialog, App) ->
    case re:run(string:join(Dialog," "), 
                regex_pattern(PatternWords),
                ?OPTIONS) of
        nomatch ->
            decomposition_rule(T, Dialog, App);
        {match, Captured} ->
            Idx = random:uniform(length(Reasmbs)),
            #reasmb{rule = Rule, value = Response} = lists:nth(Idx, Reasmbs),
            case Rule of
                replace -> 
                    NewResponse = replace_var(Response, Captured, App),
                    {match, NewResponse};
                goto -> 
                    {goto, Response}
            end
    end.

replace_var(Response, Captured, App) ->
    '_replace_var'(Response, Captured, [], App).
'_replace_var'([], _Captured, Acc, _App) ->
    lists:reverse(Acc);
'_replace_var'([H|T], Captured, Acc, App) ->
    case re:run(H, ?VAR, ?OPTIONS) of
        {match, [CapIdxStr]} -> 
            {CapIdx,_} = string:to_integer(CapIdxStr),
            MatchStr = lists:nth(CapIdx, Captured),
            MatchWords = string:tokens(MatchStr, ?SEP),
            PostWords = lists:reverse(postprocess(MatchWords, App)),
            '_replace_var'(T, Captured, PostWords ++ Acc, App);
        nomatch -> 
            '_replace_var'(T, Captured, [H|Acc], App)
    end.

regex_pattern(Pattern) ->
    lists:flatten('_regex_pattern'(Pattern)).
'_regex_pattern'([]) -> [];
'_regex_pattern'([H|[]=T]) -> [H|'_regex_pattern'(T)];
'_regex_pattern'([[$(,$.,$*,$)]=H|T]) -> [H|'_regex_pattern'(T)];
'_regex_pattern'([H|T]) -> [H, $ |'_regex_pattern'(T)].
