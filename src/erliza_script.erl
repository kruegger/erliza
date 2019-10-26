%% Automatically generated source file.
-module(erliza_script).
-export([initial/0]).
-export([final/0]).
-export([quit/1]).
-export([pre/1]).
-export([post/1]).
-export([synon/1]).
-export([key/1]).

initial() ->
    ["How","do","you","do.","Please","tell","me","your","problem."].

final() ->
    ["Goodbye.","Thank","you","for","talking","to","me."].

quit([$q,$u,$i,$t]) -> true;
quit([$g,$o,$o,$d,$b,$y,$e]) -> true;
quit([$b,$y,$e]) -> true;
quit(_) -> false.

pre([$s,$a,$m,$e]) ->
    ["alike"];
pre([$i,$',$m]) ->
    ["i","am"];
pre([$y,$o,$u,$',$r,$e]) ->
    ["you","are"];
pre([$w,$e,$r,$e]) ->
    ["was"];
pre([$c,$o,$m,$p,$u,$t,$e,$r,$s]) ->
    ["computer"];
pre([$m,$a,$c,$h,$i,$n,$e]) ->
    ["computer"];
pre([$c,$e,$r,$t,$a,$i,$n,$l,$y]) ->
    ["yes"];
pre([$w,$h,$e,$n]) ->
    ["what"];
pre([$h,$o,$w]) ->
    ["what"];
pre([$m,$a,$y,$b,$e]) ->
    ["perhaps"];
pre([$d,$r,$e,$a,$m,$s]) ->
    ["dream"];
pre([$d,$r,$e,$a,$m,$t]) ->
    ["dreamed"];
pre([$r,$e,$c,$o,$l,$l,$e,$c,$t]) ->
    ["remember"];
pre([$w,$o,$n,$t]) ->
    ["won't"];
pre([$c,$a,$n,$t]) ->
    ["can't"];
pre([$d,$o,$n,$t]) ->
    ["don't"];
pre(_) ->
    [].

post([$i,$',$m]) ->
    ["you","are"];
post([$m,$y]) ->
    ["your"];
post([$y,$o,$u]) ->
    ["I"];
post([$i]) ->
    ["you"];
post([$y,$o,$u,$r,$s,$e,$l,$f]) ->
    ["myself"];
post([$m,$y,$s,$e,$l,$f]) ->
    ["yourself"];
post([$m,$e]) ->
    ["you"];
post([$y,$o,$u,$r]) ->
    ["my"];
post([$a,$m]) ->
    ["are"];
post(_) ->
    [].

synon([$b,$e]) ->
    ["am","is","are","was"];
synon([$e,$v,$e,$r,$y,$o,$n,$e]) ->
    ["everybody","nobody","noone"];
synon([$c,$a,$n,$n,$o,$t]) ->
    ["can't"];
synon([$h,$a,$p,$p,$y]) ->
    ["elated","glad","better"];
synon([$s,$a,$d]) ->
    ["unhappy","depressed","sick"];
synon([$d,$e,$s,$i,$r,$e]) ->
    ["want","need"];
synon([$f,$a,$m,$i,$l,$y]) ->
    ["mother","mom","father","dad","sister","brother","wife","children","child"];
synon([$b,$e,$l,$i,$e,$f]) ->
    ["feel","think","believe","wish"];
synon(_) ->
    [].

key([$l,$i,$k,$e]) ->
    {10,[{decomp,["(.*)","(be|am|is|are|was)","(.*)like","(.*)"],
         1,
         [{reasmb,goto,"alike"}]}]};
key([$a,$l,$i,$k,$e]) ->
    {10,[{decomp,["(.*)"],
         1,
         [{reasmb,replace,["In","what","way","?"]},
          {reasmb,replace,["What","resemblence","do","you","see","?"]},
          {reasmb,replace,
                  ["What","does","that","similarity","suggest","to","you",
                   "?"]},
          {reasmb,replace,["What","other","connections","do","you","see","?"]},
          {reasmb,replace,
                  ["What","do","you","suppose","that","resemblence","means",
                   "?"]},
          {reasmb,replace,
                  ["What","is","the","connection,","do","you","suppose","?"]},
          {reasmb,replace,
                  ["Could","here","really","be","some","connection","?"]},
          {reasmb,replace,["How","?"]}]}]};
key([$a,$l,$w,$a,$y,$s]) ->
    {1,[{decomp,["(.*)"],
         1,
         [{reasmb,replace,
                  ["Can","you","think","of","a","specific","example","?"]},
          {reasmb,replace,["When","?"]},
          {reasmb,replace,["What","incident","are","you","thinking","of","?"]},
          {reasmb,replace,["Really,","always","?"]}]}]};
key([$n,$o,$o,$n,$e]) ->
    {2,[{decomp,["(.*)"],1,[{reasmb,goto,"everyone"}]}]};
key([$n,$o,$b,$o,$d,$y]) ->
    {2,[{decomp,["(.*)"],1,[{reasmb,goto,"everyone"}]}]};
key([$e,$v,$e,$r,$y,$b,$o,$d,$y]) ->
    {2,[{decomp,["(.*)"],1,[{reasmb,goto,"everyone"}]}]};
key([$e,$v,$e,$r,$y,$o,$n,$e]) ->
    {2,[{decomp,["(.*)","(everyone|everybody|nobody|noone)","(.*)"],
         1,
         [{reasmb,replace,["Realy,","(2)","?"]},
          {reasmb,replace,["Surely","not","(2)."]},
          {reasmb,replace,
                  ["Can","you","think","of","anyone","in","particular","?"]},
          {reasmb,replace,["Who,","for","example?"]},
          {reasmb,replace,
                  ["Are","you","thinking","of","a","very","special","person",
                   "?"]},
          {reasmb,replace,["Who,","may","I","ask","?"]},
          {reasmb,replace,["Someone","special","perhaps","?"]},
          {reasmb,replace,
                  ["You","have","a","particular","person","in","mind,",
                   "don't","you","?"]},
          {reasmb,replace,
                  ["Who","do","you","think","you're","talking","about",
                   "?"]}]}]};
key([$w,$h,$y]) ->
    {0,[{decomp,["(.*)","why","don't","you","(.*)"],
         1,
         [{reasmb,replace,["Do","you","believe","I","don't","(2)","?"]},
          {reasmb,replace,["Perhaps","I","will","(2)","in","good","time."]},
          {reasmb,replace,["Should","you","(2)","yourself","?"]},
          {reasmb,replace,["You","want","me","to","(2)","?"]},
          {reasmb,goto,"what"}]},
 {decomp,["(.*)","why","can't","i","(.*)"],
         1,
         [{reasmb,replace,
                  ["Do","you","think","you","should","be","able","to","(2)",
                   "?"]},
          {reasmb,replace,["Do","you","want","to","be","able","to","(2)","?"]},
          {reasmb,replace,
                  ["Do","you","believe","this","will","help","you","to","(2)",
                   "?"]},
          {reasmb,replace,
                  ["Have","you","any","idea","why","you","can't","(2)","?"]},
          {reasmb,goto,"what"}]},
 {decomp,["(.*)"],1,[{reasmb,goto,"what"}]}]};
key([$b,$e,$c,$a,$u,$s,$e]) ->
    {0,[{decomp,["(.*)"],
         1,
         [{reasmb,replace,["Is","that","the","real","reason","?"]},
          {reasmb,replace,
                  ["Don't","any","other","reasons","come","to","mind","?"]},
          {reasmb,replace,
                  ["Does","that","reason","seem","to","explain","anything",
                   "else","?"]},
          {reasmb,replace,
                  ["What","other","reasons","might","there","be","?"]}]}]};
key([$w,$h,$a,$t]) ->
    {0,[{decomp,["(.*)"],
         1,
         [{reasmb,replace,["Why","do","you","ask","?"]},
          {reasmb,replace,["Does","that","question","interest","you","?"]},
          {reasmb,replace,
                  ["What","is","it","you","really","wanted","to","know","?"]},
          {reasmb,replace,
                  ["Are","such","questions","much","on","your","mind","?"]},
          {reasmb,replace,["What","answer","would","please","you","most","?"]},
          {reasmb,replace,["What","do","you","think","?"]},
          {reasmb,replace,
                  ["What","comes","to","mind","when","you","ask","that","?"]},
          {reasmb,replace,
                  ["Have","you","asked","such","questions","before","?"]},
          {reasmb,replace,["Have","you","asked","anyone","else","?"]}]}]};
key([$m,$y]) ->
    {2,[{decomp,["$","(.*)","my","(.*)"],
         1,
         [{reasmb,replace,["Lets","discuss","further","why","your","(2)."]},
          {reasmb,replace,["Earlier","you","said","your","(2)."]},
          {reasmb,replace,["But","your","(2)."]},
          {reasmb,replace,
                  ["Does","that","have","anything","to","do","with","the",
                   "fact","that","your","(2)","?"]}]},
 {decomp,["(.*)","my(.*)",
          "(family|mother|mom|father|dad|sister|brother|wife|children|child)",
          "(.*)"],
         1,
         [{reasmb,replace,["Tell","me","more","about","your","family."]},
          {reasmb,replace,["Who","else","in","your","family","(4)","?"]},
          {reasmb,replace,["Your","(3)","?"]},
          {reasmb,replace,
                  ["What","else","comes","to","mind","when","you","think",
                   "of","your","(3)","?"]}]},
 {decomp,["(.*)","my","(.*)"],
         1,
         [{reasmb,replace,["Your","(2)","?"]},
          {reasmb,replace,["Why","do","you","say","your","(2)","?"]},
          {reasmb,replace,
                  ["Does","that","suggest","anything","else","which",
                   "belongs","to","you","?"]},
          {reasmb,replace,["Is","it","important","that","your","(2)","?"]}]}]};
key([$n,$o]) ->
    {0,[{decomp,["(.*)"],
         1,
         [{reasmb,replace,
                  ["Are","you","saying","no","just","to","be","negative?"]},
          {reasmb,replace,["You","are","being","a","bit","negative."]},
          {reasmb,replace,["Why","not","?"]},
          {reasmb,replace,["Why","'no'","?"]}]}]};
key([$y,$e,$s]) ->
    {0,[{decomp,["(.*)"],
         1,
         [{reasmb,replace,["You","seem","to","be","quite","positive."]},
          {reasmb,replace,["You","are","sure."]},
          {reasmb,replace,["I","see."]},
          {reasmb,replace,["I","understand."]}]}]};
key([$y,$o,$u]) ->
    {0,[{decomp,["(.*)","you","remind","me","of","(.*)"],1,[{reasmb,goto,"alike"}]},
 {decomp,["(.*)","you","are","(.*)"],
         1,
         [{reasmb,replace,["What","makes","you","think","I","am","(2)","?"]},
          {reasmb,replace,
                  ["Does","it","please","you","to","believe","I","am","(2)",
                   "?"]},
          {reasmb,replace,
                  ["Do","you","sometimes","wish","you","were","(2)","?"]},
          {reasmb,replace,["Perhaps","you","would","like","to","be","(2)."]}]},
 {decomp,["(.*)","you(.*)","me","(.*)"],
         1,
         [{reasmb,replace,["Why","do","you","think","I","(2)","you","?"]},
          {reasmb,replace,
                  ["You","like","to","think","I","(2)","you","--","don't",
                   "you","?"]},
          {reasmb,replace,["What","makes","you","think","I","(2)","you","?"]},
          {reasmb,replace,["Really,","I","(2)","you","?"]},
          {reasmb,replace,
                  ["Do","you","wish","to","believe","I","(2)","you","?"]},
          {reasmb,replace,
                  ["Suppose","I","did","(2)","you","--","what","would","that",
                   "mean","?"]},
          {reasmb,replace,
                  ["Does","someone","else","believe","I","(2)","you","?"]}]},
 {decomp,["(.*)","you","(.*)"],
         1,
         [{reasmb,replace,["We","were","discussing","you","--","not","me."]},
          {reasmb,replace,["Oh,","I","(2)","?"]},
          {reasmb,replace,
                  ["You're","not","really","talking","about","me","--","are",
                   "you","?"]},
          {reasmb,replace,["What","are","your","feelings","now","?"]}]}]};
key([$c,$a,$n]) ->
    {0,[{decomp,["(.*)","can","you","(.*)"],
         1,
         [{reasmb,replace,["You","believe","I","can","(2)","don't","you","?"]},
          {reasmb,goto,"what"},
          {reasmb,replace,["You","want","me","to","be","able","to","(2)."]},
          {reasmb,replace,
                  ["Perhaps","you","would","like","to","be","able","to","(2)",
                   "yourself."]}]},
 {decomp,["(.*)","can","i","(.*)"],
         1,
         [{reasmb,replace,
                  ["Whether","or","not","you","can","(2)","depends","on",
                   "you","more","than","me."]},
          {reasmb,replace,["Do","you","want","to","be","able","to","(2)","?"]},
          {reasmb,replace,["Perhaps","you","don't","want","to","(2)."]},
          {reasmb,goto,"what"}]}]};
key([$i]) ->
    {0,[{decomp,["(.*)","i","(desire|want|need)","(.*)"],
         1,
         [{reasmb,replace,
                  ["What","would","it","mean","to","you","if","you","got",
                   "(3)","?"]},
          {reasmb,replace,["Why","do","you","want","(3)","?"]},
          {reasmb,replace,["Suppose","you","got","(3)","soon","?"]},
          {reasmb,replace,["What","if","you","never","got","(3)","?"]},
          {reasmb,replace,
                  ["What","would","getting","(3)","mean","to","you","?"]},
          {reasmb,replace,
                  ["What","does","wanting","(3)","have","to","do","with",
                   "this","discussion","?"]}]},
 {decomp,["(.*)","i","am(.*)","(sad|unhappy|depressed|sick)","(.*)"],
         1,
         [{reasmb,replace,
                  ["I","am","sorry","to","hear","that","you","are","(3)."]},
          {reasmb,replace,
                  ["Do","you","think","that","coming","here","will","help",
                   "you","not","to","be","(3)","?"]},
          {reasmb,replace,
                  ["I'm","sure","it's","not","pleasant","to","be","(3)."]},
          {reasmb,replace,
                  ["Can","you","explain","what","made","you","(3)","?"]}]},
 {decomp,["(.*)","i","am(.*)","(happy|elated|glad|better)","(.*)"],
         1,
         [{reasmb,replace,
                  ["How","have","I","helped","you","to","be","(3)","?"]},
          {reasmb,replace,["Has","your","treatment","made","you","(3)","?"]},
          {reasmb,replace,["What","makes","you","(3)","just","now","?"]},
          {reasmb,replace,
                  ["Can","you","explan","why","you","are","suddenly","(3)",
                   "?"]}]},
 {decomp,["(.*)","i","was","(.*)"],1,[{reasmb,goto,"was"}]},
 {decomp,["(.*)","i","(belief|feel|think|believe|wish)","(.*)","i","(.*)"],
         1,
         [{reasmb,replace,["Do","you","really","think","so","?"]},
          {reasmb,replace,["But","you","are","not","sure","you","(3)."]},
          {reasmb,replace,["Do","you","really","doubt","you","(3)","?"]}]},
 {decomp,["(.*)","i(.*)","(belief|feel|think|believe|wish)","(.*)you","(.*)"],
         1,
         [{reasmb,goto,"you"}]},
 {decomp,["(.*)","i","am","(.*)"],
         1,
         [{reasmb,replace,
                  ["Is","it","because","you","are","(2)","that","you","came",
                   "to","me","?"]},
          {reasmb,replace,["How","long","have","you","been","(2)","?"]},
          {reasmb,replace,
                  ["Do","you","believe","it","is","normal","to","be","(2)",
                   "?"]},
          {reasmb,replace,["Do","you","enjoy","being","(2)","?"]}]},
 {decomp,["(.*)","i","(cannot|can't)","(.*)"],
         1,
         [{reasmb,replace,
                  ["How","do","you","think","that","you","can't","(3)","?"]},
          {reasmb,replace,["Have","you","tried","?"]},
          {reasmb,replace,["Perhaps","you","could","(3)","now."]},
          {reasmb,replace,
                  ["Do","you","really","want","to","be","able","to","(3)",
                   "?"]}]},
 {decomp,["(.*)","i","don't","(.*)"],
         1,
         [{reasmb,replace,["Don't","you","really","(2)","?"]},
          {reasmb,replace,["Why","don't","you","(2)","?"]},
          {reasmb,replace,["Do","you","wish","to","be","able","to","(2)","?"]},
          {reasmb,replace,["Does","that","trouble","you","?"]}]},
 {decomp,["(.*)","do","i","feel","(.*)"],
         1,
         [{reasmb,replace,["Tell","me","more","about","such","feelings."]},
          {reasmb,replace,["Do","you","often","feel","(2)","?"]},
          {reasmb,replace,["Do","you","enjoy","feeling","(2)","?"]},
          {reasmb,replace,
                  ["Of","what","does","feeling","(2)","remind","you","?"]}]},
 {decomp,["(.*)","i","(.*)","you","(.*)"],
         1,
         [{reasmb,replace,
                  ["Perhaps","in","your","fantasies","we","(2)","each",
                   "other."]},
          {reasmb,replace,["Do","you","wish","to","(2)","me","?"]},
          {reasmb,replace,["You","seem","to","need","to","(2)","me."]},
          {reasmb,replace,["Do","you","(2)","anyone","else","?"]}]},
 {decomp,["(.*)"],
         1,
         [{reasmb,replace,["You","say","(1)","?"]},
          {reasmb,replace,["Can","you","elaborate","on","that","?"]},
          {reasmb,replace,
                  ["Do","you","say","(1)","for","some","special","reason",
                   "?"]},
          {reasmb,replace,["That's","quite","interesting."]}]}]};
key([$w,$a,$s]) ->
    {2,[{decomp,["(.*)","was","i","(.*)"],
         1,
         [{reasmb,replace,["What","if","you","were","(2)","?"]},
          {reasmb,replace,["Do","you","think","you","were","(2)","?"]},
          {reasmb,replace,["Were","you","(2)","?"]},
          {reasmb,replace,
                  ["What","would","it","mean","if","you","were","(2)","?"]},
          {reasmb,replace,["What","does","(2)","suggest","to","you","?"]},
          {reasmb,goto,"what"}]},
 {decomp,["(.*)","i","was","(.*)"],
         1,
         [{reasmb,replace,["Were","you","really","?"]},
          {reasmb,replace,
                  ["Why","do","you","tell","me","you","were","(2)","now","?"]},
          {reasmb,replace,
                  ["Perhaps","I","already","know","you","were","(2)."]}]},
 {decomp,["(.*)","was","you","(.*)"],
         1,
         [{reasmb,replace,
                  ["Would","you","like","to","believe","I","was","(2)","?"]},
          {reasmb,replace,["What","suggests","that","I","was","(2)","?"]},
          {reasmb,replace,["What","do","you","think","?"]},
          {reasmb,replace,["Perhaps","I","was","(2)."]},
          {reasmb,replace,["What","if","I","had","been","(2)","?"]}]}]};
key([$y,$o,$u,$r]) ->
    {0,[{decomp,["(.*)","your","(.*)"],
         1,
         [{reasmb,replace,
                  ["Why","are","you","concerned","over","my","(2)","?"]},
          {reasmb,replace,["What","about","your","own","(2)","?"]},
          {reasmb,replace,
                  ["Are","you","worried","about","someone","else's","(2)",
                   "?"]},
          {reasmb,replace,["Really,","my","(2)","?"]}]}]};
key([$a,$r,$e]) ->
    {0,[{decomp,["(.*)","are","you","(.*)"],
         1,
         [{reasmb,replace,
                  ["Why","are","you","interested","in","whether","I","am",
                   "(2)","or","not","?"]},
          {reasmb,replace,
                  ["Would","you","prefer","if","I","weren't","(2)","?"]},
          {reasmb,replace,["Perhaps","I","am","(2)","in","your","fantasies."]},
          {reasmb,replace,["Do","you","sometimes","think","I","am","(2)","?"]},
          {reasmb,goto,"what"}]},
 {decomp,["(.*)","are","(.*)"],
         1,
         [{reasmb,replace,
                  ["Did","you","think","they","might","not","be","(2)","?"]},
          {reasmb,replace,
                  ["Would","you","like","it","if","they","were","not","(2)",
                   "?"]},
          {reasmb,replace,["What","if","they","were","not","(2)","?"]},
          {reasmb,replace,["Possibly","they","are","(2)."]}]}]};
key([$a,$m]) ->
    {0,[{decomp,["(.*)","am","i","(.*)"],
         1,
         [{reasmb,replace,["Do","you","believe","you","are","(2)","?"]},
          {reasmb,replace,["Would","you","want","to","be","(2)","?"]},
          {reasmb,replace,
                  ["Do","you","wish","I","would","tell","you","you","are",
                   "(2)","?"]},
          {reasmb,replace,
                  ["What","would","it","mean","if","you","were","(2)","?"]},
          {reasmb,goto,"what"}]},
 {decomp,["(.*)"],
         1,
         [{reasmb,replace,["Why","do","you","say","'am'","?"]},
          {reasmb,replace,["I","don't","understand","that."]}]}]};
key([$c,$o,$m,$p,$u,$t,$e,$r]) ->
    {50,[{decomp,["(.*)"],
         1,
         [{reasmb,replace,["Do","computers","worry","you","?"]},
          {reasmb,replace,["Why","do","you","mention","computers","?"]},
          {reasmb,replace,
                  ["What","do","you","think","machines","have","to","do",
                   "with","your","problem","?"]},
          {reasmb,replace,
                  ["Don't","you","think","computers","can","help","people",
                   "?"]},
          {reasmb,replace,["What","about","machines","worrys","you","?"]},
          {reasmb,replace,
                  ["What","do","you","think","about","machines","?"]}]}]};
key([$h,$e,$l,$l,$o]) ->
    {0,[{decomp,["(.*)"],
         1,
         [{reasmb,replace,
                  ["How","do","you","do.","Please","state","your","problem."]},
          {reasmb,replace,
                  ["Hi.","What","seems","to","be","your","problem","?"]}]}]};
key([$x,$f,$o,$r,$e,$i,$g,$n]) ->
    {0,[{decomp,["(.*)"],1,[{reasmb,replace,["I","speak","only","English."]}]}]};
key([$e,$s,$p,$a,$n,$o,$l]) ->
    {0,[{decomp,["(.*)"],
         1,
         [{reasmb,goto,"xforeign"},
          {reasmb,replace,
                  ["I","told","you","before,","I","don't","understand",
                   "Spanish."]}]}]};
key([$i,$t,$a,$l,$i,$a,$n,$o]) ->
    {0,[{decomp,["(.*)"],
         1,
         [{reasmb,goto,"xforeign"},
          {reasmb,replace,
                  ["I","told","you","before,","I","don't","understand",
                   "Italian."]}]}]};
key([$f,$r,$a,$n,$c,$a,$i,$s]) ->
    {0,[{decomp,["(.*)"],
         1,
         [{reasmb,goto,"xforeign"},
          {reasmb,replace,
                  ["I","told","you","before,","I","don't","understand",
                   "French."]}]}]};
key([$d,$e,$u,$t,$s,$c,$h]) ->
    {0,[{decomp,["(.*)"],
         1,
         [{reasmb,goto,"xforeign"},
          {reasmb,replace,
                  ["I","told","you","before,","I","don't","understand",
                   "German."]}]}]};
key([$n,$a,$m,$e]) ->
    {15,[{decomp,["(.*)"],
         1,
         [{reasmb,replace,["I","am","not","interested","in","names."]},
          {reasmb,replace,
                  ["I've","told","you","before,","I","don't","care","about",
                   "names","--","please","continue."]}]}]};
key([$p,$e,$r,$h,$a,$p,$s]) ->
    {0,[{decomp,["(.*)"],
         1,
         [{reasmb,replace,["You","don't","seem","quite","certain."]},
          {reasmb,replace,["Why","the","uncertain","tone","?"]},
          {reasmb,replace,["Can't","you","be","more","positive","?"]},
          {reasmb,replace,["You","aren't","sure","?"]},
          {reasmb,replace,["Don't","you","know","?"]}]}]};
key([$d,$r,$e,$a,$m]) ->
    {3,[{decomp,["(.*)"],
         1,
         [{reasmb,replace,
                  ["What","does","that","dream","suggest","to","you","?"]},
          {reasmb,replace,["Do","you","dream","often","?"]},
          {reasmb,replace,
                  ["What","persons","appear","in","your","dreams","?"]},
          {reasmb,replace,
                  ["Do","you","believe","that","dreams","have","something",
                   "to","do","with","your","problems","?"]}]}]};
key([$d,$r,$e,$a,$m,$e,$d]) ->
    {4,[{decomp,["(.*)","i","dreamed","(.*)"],
         1,
         [{reasmb,replace,["Really,","(2)","?"]},
          {reasmb,replace,
                  ["Have","you","ever","fantasized","(2)","while","you",
                   "were","awake","?"]},
          {reasmb,replace,["Have","you","ever","dreamed","(2)","before","?"]},
          {reasmb,goto,"dream"}]}]};
key([$i,$f]) ->
    {3,[{decomp,["(.*)","if","(.*)"],
         1,
         [{reasmb,replace,
                  ["Do","you","think","its","likely","that","(2)","?"]},
          {reasmb,replace,["Do","you","wish","that","(2)","?"]},
          {reasmb,replace,["What","do","you","know","about","(2)","?"]},
          {reasmb,replace,["Really,","if","(2)","?"]}]}]};
key([$r,$e,$m,$e,$m,$b,$e,$r]) ->
    {5,[{decomp,["(.*)","i","remember","(.*)"],
         1,
         [{reasmb,replace,["Do","you","often","think","of","(2)","?"]},
          {reasmb,replace,
                  ["Does","thinking","of","(2)","bring","anything","else",
                   "to","mind","?"]},
          {reasmb,replace,["What","else","do","you","recollect","?"]},
          {reasmb,replace,
                  ["Why","do","you","recollect","(2)","just","now","?"]},
          {reasmb,replace,
                  ["What","in","the","present","situation","reminds","you",
                   "of","(2)","?"]},
          {reasmb,replace,
                  ["What","is","the","connection","between","me","and","(2)",
                   "?"]}]},
 {decomp,["(.*)","do","you","remember","(.*)"],
         1,
         [{reasmb,replace,
                  ["Did","you","think","I","would","forget","(2)","?"]},
          {reasmb,replace,
                  ["Why","do","you","think","I","should","recall","(2)","now",
                   "?"]},
          {reasmb,replace,["What","about","(2)","?"]},
          {reasmb,goto,"what"},
          {reasmb,replace,["You","mentioned","(2)","?"]}]}]};
key([$a,$p,$o,$l,$o,$g,$i,$s,$e]) ->
    {0,[{decomp,["(.*)"],1,[{reasmb,goto,"sorry"}]}]};
key([$s,$o,$r,$r,$y]) ->
    {0,[{decomp,["(.*)"],
         1,
         [{reasmb,replace,["Please","don't","apologise."]},
          {reasmb,replace,["Apologies","are","not","necessary."]},
          {reasmb,replace,
                  ["I've","told","you","that","apologies","are","not",
                   "required."]}]}]};
key([$x,$n,$o,$n,$e]) ->
    {0,[{decomp,["(.*)"],
         1,
         [{reasmb,replace,
                  ["I'm","not","sure","I","understand","you","fully."]},
          {reasmb,replace,["Please","go","on."]},
          {reasmb,replace,["What","does","that","suggest","to","you","?"]},
          {reasmb,replace,
                  ["Do","you","feel","strongly","about","discussing","such",
                   "things","?"]}]}]};
key(_) ->
    [].

