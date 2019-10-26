%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%     Erliza rule code generator and compiler
%%% @end
%%% Created : 26 Jan 2019 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(erliza_rule).

-include("erliza.hrl").

-define(GENERATE, io_lib:format).
-define(CONT, ";\n").
-define(END, ".\n\n").

%% API
-export([preprocess/1, compile/2, compile_and_run/0, get_line_tokens/1]).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

preprocess([File, OptsString]) ->
    Opts = erliza_utils:string_to_term(OptsString), 
    State = erliza_utils:parse_opts(Opts),
    Name = erliza_utils:get_opts(erliza_app, State),
    OutFile = io_lib:format("~s~s" ,[atom_to_list(Name), ?ERLIZA_RULE_CODE_EXT]),
    Script = File,
    Tokens = tuple_to_list(xfrm_script(Script)),
    Code = ["%% Automatically generated source file.\n",
     ?GENERATE("-module(~p).\n", [Name]),
     exports(Tokens),
     "\n",
     '_func_clause'(Tokens)],
    ok = file:write_file(OutFile, Code),
    stop(State).

compile(File, OutDir) ->
    SourceFilename = filename:join(OutDir, File),
    case compile:file(SourceFilename, [{outdir, OutDir}]) of
        {ok, _} ->
            file:delete(SourceFilename),
            ok;
        error ->
            file:delete(SourceFilename),
            {error, "Error: Internal compilation error"};
        ErrorDescriptor ->
            file:delete(SourceFilename),
            {error,
             io_lib:format("Error: ~s~n",
                     [compile:format_error(ErrorDescriptor)])}
    end.

stop(#{noinput := true}) -> halt(0);
stop(_State) -> ok.

%%%===================================================================
%%% Internal functions
%%%===================================================================

exports(Funcs) ->
    lists:map(fun({Name, _}) ->
                      ?GENERATE("-export([~p/0]).\n", [Name]);
                 ({internal, _, _}) -> [];
                 ([H|_]) ->
                      ?GENERATE("-export([~p/1]).\n", [element(1,H)]) 
              end, Funcs).

'_func_clause'([]) -> [];
'_func_clause'([{Name, Body}|T]) when is_list(Body)  ->
    [?GENERATE("~p() ->~n    ", [Name]), 
     '_func_return'({list, Body}), ?END|'_func_clause'(T)];
'_func_clause'([{Name, Body}|T]) ->
    [?GENERATE("~p() ->~n    ", [Name]), 
     '_func_return'(Body), ?END|'_func_clause'(T)];
'_func_clause'([{internal, Name, Body}|T]) ->
    [?GENERATE("~p() ->~n    ", [Name]), 
     '_func_return'(Body), ?END|'_func_clause'(T)];
'_func_clause'([{Name, Param, Body}|T]) ->
    [?GENERATE("~p(~s) ->~n    ", [Name, '_func_return_list'(Param)]), 
     '_func_return'(Body), ?END|'_func_clause'(T)];
'_func_clause'([H|T]) when is_list(H) -> 
    ['_func_decl'(H)|'_func_clause'(T)];
'_func_clause'([_|T]) -> '_func_clause'(T).

'_func_decl'([]) -> [];
'_func_decl'([{quit = Name, [Arg]}|[]=T]) when is_list(Arg)  ->
    C1 = [?GENERATE("~p([~s]) -> true", [Name, '_func_arg'(Arg)]), ?CONT],
    C2 = [?GENERATE("~p([_]) -> false", [Name]), ?END],
    [C1,C2|'_func_decl'(T)];
'_func_decl'([{Name, Arg}|[]=T]) when is_list(Arg)  ->
    C1 = [?GENERATE("~p([~s]) -> true", [Name, '_func_arg'(Arg)]), ?CONT],
    C2 = [?GENERATE("~p(_) -> false", [Name]), ?END],
    [C1, C2|'_func_decl'(T)];
'_func_decl'([{internal, Name, Body}|[]=T]) ->
    C = [?GENERATE("~p() ->~n    ", [Name]), '_func_return'(Body), ?END],
    [C|'_func_decl'(T)];
'_func_decl'([{key = Name, Arg, Body}|[]=T]) ->
    C1 = [?GENERATE("~p([~s]) ->~n    ", [Name, '_func_arg'(Arg)]), '_func_return'({tuple, {undefined, Body}}), ?CONT],
    C2 = [?GENERATE("~p(_) ->~n    ", [Name]), '_func_return'([]), ?END],
    [C1, C2|'_func_decl'(T)];
'_func_decl'([{Name, Arg, Body}|[]=T]) ->
    C1 = [?GENERATE("~p([~s]) ->~n    ", [Name, '_func_arg'(Arg)]), '_func_return'(Body), ?CONT],
    C2 = [?GENERATE("~p(_) ->~n    ", [Name]), '_func_return'([]), ?END],
    [C1, C2|'_func_decl'(T)];
'_func_decl'([{Name, Arg, Priority, Body}|[]=T]) ->
    C1 = [?GENERATE("~p([~s]) ->~n    ", [Name, '_func_arg'(Arg)]), '_func_return'({tuple, {list_to_integer(Priority), Body}}), ?CONT],
    C2 = [?GENERATE("~p(_) ->~n    ", [Name]), '_func_return'([]), ?END],
    [C1, C2|'_func_decl'(T)];
'_func_decl'([{quit = Name, [Arg]}|T]) when is_list(Arg)  ->
    C = [?GENERATE("~p([~s]) -> true", [Name, '_func_arg'(Arg)]), ?CONT],
    [C|'_func_decl'(T)];
'_func_decl'([{Name, Arg}|T]) when is_list(Arg)  ->
    C = [?GENERATE("~p([~s]) -> true", [Name, '_func_arg'(Arg)]), ?CONT],
    [C|'_func_decl'(T)];
'_func_decl'([{internal, Name, Body}|T]) ->
    C = [?GENERATE("~p() ->~n    ", [Name]), '_func_return'(Body), ?CONT],
    [C|'_func_decl'(T)];
'_func_decl'([{key = Name, Arg, Body}|T]) ->
    C = [?GENERATE("~p([~s]) ->~n    ", [Name, '_func_arg'(Arg)]), '_func_return'({tuple, {undefined, Body}}), ?CONT],
    [C|'_func_decl'(T)];
'_func_decl'([{Name, Arg, Body}|T]) ->
    C = [?GENERATE("~p([~s]) ->~n    ", [Name, '_func_arg'(Arg)]), '_func_return'(Body), ?CONT],
    [C|'_func_decl'(T)];
'_func_decl'([{Name, Arg, Priority, Body}|T]) ->
%    io:format("DEBUG ~p~n", [H]),
    C = [?GENERATE("~p([~s]) ->~n    ", [Name, '_func_arg'(Arg)]), '_func_return'({tuple, {list_to_integer(Priority), Body}}), ?CONT],
    [C|'_func_decl'(T)].

'_func_return_list'([E]) ->
    '_func_return'(E);
'_func_return_list'([E|Es]) ->
    ['_func_return'(E), $, | '_func_return_list'(Es)];
'_func_return_list'([]) -> [].

'_func_return'({data, E}) -> ?GENERATE("~p", [E]);
'_func_return'({func, F}) -> ?GENERATE("~s()",[F]);
'_func_return'({list, L}) when is_list(L) ->
    [$[,'_func_return_list'(L),$]];
'_func_return'({tuple,T}) when is_tuple(T) ->
    [${,'_func_return_list'(tuple_to_list(T)),$}];
'_func_return'(R) ->
    ?GENERATE("~p", [R]).

'_func_arg'([]) -> [];
'_func_arg'([H|[]=T]) -> 
    [$$, H|'_func_arg'(T)];
'_func_arg'([H|T]) ->
    [$$, H, $,|'_func_arg'(T)].

xfrm_script(File) ->
    case parse_script(File) of
        {ok, ScriptLs} -> extract_and_init_script(ScriptLs);
        Err -> Err
    end.

parse_script(File) ->
    case get_tokens(File) of
        {ok, Tokens} ->   
            %io:format("tokens:~p~n",[Tokens]),
            get_parsed(Tokens);
        ErrToken ->
            %io:format("err:~p when get tokens~n",[ErrToken]),
            ErrToken
    end.


get_tokens(File) ->
    case file:open(File,[read]) of
        {ok, IO} ->
            token_loop(IO,[]);
        ErrorFile ->
            io:format("err when read file ~p~n",[ErrorFile]),
            ErrorFile
    end.

token_loop(IO, Acc) -> 
    case file:read_line(IO) of
        {ok, Line} -> 
            %io:format("DEBUG ~p~n",[Line]),
            case erliza_leex:string(Line) of
                {ok, Tokens, _} -> 
                    token_loop(IO, Acc ++ Tokens);
                Err -> 
                    io:format("err:~p when get tokens on Line ~p~n",[Err,Line]),
                    Err
            end;
         eof -> 
             {ok, Acc};
         ErrFile ->
             io:format("file read line error ~p~n",[ErrFile]),
             ErrFile
     end.
         

get_parsed(Tokens) ->
    case erliza_yecc:parse(Tokens) of
        {ok, Res} -> 
            {ok, Res};
        Err ->
            io:format("err ~p when parse tokens~n", [Err]),
            Err
    end.

    
import_script_verbose(FilePath) -> 
    case file:open(FilePath,[read]) of
        {ok, IO} ->
            erliza_yecc:parse_and_scan({?MODULE,get_line_tokens,[IO]});
        Err ->
            io:format("open file err ~p~n",[Err])
    end.

get_line_tokens(IO) ->
    case file:read_line(IO) of
        {ok, Line} -> 
            io:format("~p~n",[Line]),
            Res = erliza_leex:string(Line),
            io:format("~p~n",[Res]),
            Res;
        eof -> 
            {eof, 1};
        Err -> 
            {error, Err, 1}
    end.

extract_and_init_script(ScriptLs) ->
    {Initial, Final, QuitLs, PreLs, PostLs, SynonLs, KeyLs} = 
        classify_script(ScriptLs),
    {Initial, Final, QuitLs, PreLs, PostLs, SynonLs,
     lists:map(fun(Key) -> pre_process_key(Key, SynonLs) end, KeyLs)}.

classify_script(ScriptLs) ->
    classify_script(ScriptLs, undefined,undefined,[],[],[],[],[]).

classify_script([], Initial, Final, QuitLs, PreLs, PostLs, SynonLs, KeyLs) ->
    {Initial, Final, QuitLs, PreLs, PostLs, SynonLs, KeyLs};

classify_script([#script{value = #initial{} = Init} | Rest], 
                _Initial, Final, QuitLs, PreLs, PostLs, SynonLs, KeyLs) ->
    classify_script(Rest, Init, Final, QuitLs, PreLs, PostLs, SynonLs, KeyLs);

classify_script([#script{value = #final{} = Fin} | Rest], 
                Initial, _Final, QuitLs, PreLs, PostLs, SynonLs, KeyLs) ->
    classify_script(Rest, Initial, Fin, QuitLs, PreLs, PostLs, SynonLs, KeyLs);
                                  
classify_script([#script{value = #quit{} = Qt} | Rest], 
                Initial, Final, QuitLs, PreLs, PostLs, SynonLs, KeyLs) ->
    classify_script(Rest, Initial, Final, [Qt | QuitLs], PreLs, PostLs, SynonLs, KeyLs);

classify_script([#script{value = #pre{} = Pre} | Rest], 
                Initial, Final, QuitLs, PreLs, PostLs, SynonLs, KeyLs) ->
    classify_script(Rest, Initial, Final, QuitLs, [Pre | PreLs], PostLs, SynonLs, KeyLs);

classify_script([#script{value = #post{} = Post} | Rest], 
                Initial, Final, QuitLs, PreLs, PostLs, SynonLs, KeyLs) ->
    classify_script(Rest, Initial, Final, QuitLs, PreLs, [Post | PostLs], SynonLs, KeyLs);

classify_script([#script{value = #synon{} = Synon} | Rest], 
                Initial, Final, QuitLs, PreLs, PostLs, SynonLs, KeyLs) ->
    classify_script(Rest, Initial, Final, QuitLs, PreLs, PostLs, [Synon | SynonLs], KeyLs);

classify_script([#script{value = #key{} = Key} | Rest], 
                Initial, Final, QuitLs, PreLs, PostLs, SynonLs, KeyLs) ->
    classify_script(Rest, Initial, Final, QuitLs, PreLs, PostLs, SynonLs, [Key | KeyLs]).


pre_process_key(#key{decomp_list = DecompLs} = Key, SynonLs) ->
    DecompLs1 = lists:map(fun(Decomp) -> convert_decomp_pattern_to_perl_style(Decomp, SynonLs) end,
                          DecompLs),
    DecompLs2 = lists:map(fun(Old) -> Old#decomp{reasmb_index = 1} end, DecompLs1),
    Key#key{decomp_list = DecompLs2}.

%% ============================================================================
%% convert regrex in script to regrex style supported by re module
%% * -> (.*), @name -> (name1|name2|..|namex)
%% ============================================================================
convert_decomp_pattern_to_perl_style(#decomp{pattern = Pattern} = Decomp, SynonLs) ->
    PatternStar = lists:map(fun(Word) -> lists:foldl(fun replace_star/2, [], Word) end,
                            Pattern),
    PatternSynon = lists:map(fun(Word) -> replace_synon(Word, SynonLs) end, PatternStar),
    Decomp#decomp{pattern = PatternSynon}.
 
replace_star($*, Acc) ->
    Acc++"(.*)";
replace_star(Other, Acc) ->
    Acc ++ [Other].

replace_synon([], _SynonLs) ->
    [];
replace_synon([$@], _SynonLs) ->
    [$@]; 
replace_synon([$@|Rest] = Old, SynonLs) ->
    case lists:keysearch(Rest, 2, SynonLs) of
         false -> Old;
         {value, #synon{sample = Rest, synon_list = Synons}} ->
             "(" ++ string:join([Rest|Synons],"|") ++ ")"
    end; 
replace_synon(Other, _SynonLs) ->
    Other.

compile_and_run() ->
    import_script_verbose("./script_test").

