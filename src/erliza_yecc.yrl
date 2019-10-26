Nonterminals
scripts script decom_pattern decom_patterns reasemb_patterns reasemb_pattern words priority name.


Terminals
word split initial final quit pre post synon key decomp reasmb number goto.

Rootsymbol scripts.
Endsymbol '$end'.

%-record(script,{value}).
%-record(initial, {init_word_list}).
%-record(final, {final_word_list}).
%-record(quit, {quit_word_list}).
%-record(pre, {orig_word, replace_word_list}).
%-record(post, {orig_word, replace_word_list}).
%-record(synon, {sample, synon_list}).
%-record(key, {keyword, priority, decomp_list}).
%-record(decomp, {pattern, reasmb_index, reasmb_list}).
%-record(reasmb, {rule, value}).
% the returned types are defined as above.
scripts -> script:[{script, '$1'}].
scripts -> script scripts:[{script, '$1'} | '$2'].
script -> initial split word words:{initial,[value('$3') | '$4']}.
script -> final split word words:{final, [value('$3') | '$4']}.
script -> quit split word:{quit, value('$3')}.
script -> quit split quit:{quit, "quit"}.
script -> pre split word words:{pre, value('$3'), '$4'}.
script -> synon split word words:{synon, value('$3'), '$4'}.
script -> post split word words:{post, value('$3'), '$4'}.
script -> key split name priority decom_patterns:{key, '$3','$4','$5'}.
words -> word:[value('$1')].
words -> word words:[value('$1') | '$2'].
priority -> '$empty':"0".
priority -> number:value('$1').
decom_patterns -> decom_pattern:['$1'].
decom_patterns -> decom_pattern decom_patterns:['$1' | '$2'].
decom_pattern -> decomp split word  reasemb_patterns:{decomp, [value('$3')], 0, '$4'}.
decom_pattern -> decomp split word words  reasemb_patterns:{decomp, [value('$3')|'$4'], 0, '$5'}.
reasemb_patterns -> reasemb_pattern:['$1'].
reasemb_patterns -> reasemb_pattern  reasemb_patterns:['$1' | '$2'].
reasemb_pattern -> reasmb split goto name:{reasmb, goto,'$4'}.
reasemb_pattern -> reasmb split word words:{reasmb, replace, [value('$3') | '$4']}. 
name -> word:value('$1').
Erlang code.
value(Token) -> element(3,Token).
