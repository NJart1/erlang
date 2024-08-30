%%%-------------------------------------------------------------------
%%% @author Author_Name <Author_Email>
%%% @copyright (C) 2024, Author_Name
%%% @doc 
%%%
%%% @end
%%% Created : 27 Aug 2024 by Author_Name <Author_Email>
%%%-------------------------------------------------------------------
-module(erl).
-export([hi/0, for/3]).

hi() -> hi.

for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I)|for(I+1, Max, F)].