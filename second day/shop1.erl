%%%-------------------------------------------------------------------
%%% @author Author_Name <Author_Email>
%%% @copyright (C) 2024, Author_Name
%%% @doc 
%%%
%%% @end
%%% Created : 27 Aug 2024 by Author_Name <Author_Email>
%%%-------------------------------------------------------------------
-module(shop1).
-export([total/1]).

total([{What, N} | T]) -> shop:cost(What) * N + total(T);
total([]) -> 0.