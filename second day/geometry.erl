%%%-------------------------------------------------------------------
%%% @author Author_Name <Author_Email>
%%% @copyright (C) 2024, Author_Name
%%% @doc 
%%%
%%% @end
%%% Created : 27 Aug 2024 by Author_Name <Author_Email>
%%%-------------------------------------------------------------------
-module(geometry).
-export([area/1, test/0]).

area({rectangle, Wigth, Height}) -> Wigth * Height;
area({square, Side}) -> Side * Side.

test() -> 
    12 = area({rectangle, 3, 4}),
    144 = area({square, 12}),
    test_worked.
