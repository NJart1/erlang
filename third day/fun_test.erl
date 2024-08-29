%%% @author Author_Name <Author_Email>
%%% @copyrfun24, Author_Nfunc 
%%%
%%% @end
%%% Created : 28 Aug 2024 by Author_Name <Author_Email>
-module(fun_test).
-export([fun_test/3]).

fun_test(Max, Max, Fun) -> [Fun(Max)];
fun_test(Min, Max, Fun) -> [Fun(Min) | fun_test(Min + 1, Max, Fun)].
