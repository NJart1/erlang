-module(math_functions).
-export([odd/1, even/1, filter/2, split/1, decimal/2]).

odd(X) -> (X rem 2) =:= 1.
even(X) -> (X rem 2) =:= 0.

filter(Fun, List) -> lists:filter(Fun, List).

% split(List) -> 
%     split(List, [],[]).
% split([], Odds, Evens) -> {lists:reverse(Evens), lists:reverse(Odds)};
% split([H|T], Odds, Evens) -> 
%     case (H rem 2) of
%         1 -> split(T, [H | Odds], Evens);
%         0 -> split(T, Odds, [H | Evens])
%     end.

split(List) -> 
    Odds = filter(fun(X) -> X rem 2 =:= 1 end, List),
    Evens = filter(fun(X) -> X rem 2 =:= 0 end, List),
    {Evens, Odds}.

decimal(0, List) -> List; 
decimal(Num, List) when Num rem 2 =:= 1 -> decimal(Num div 2, [1 | List]);
decimal(Num, List) -> decimal(Num div 2, [0 | List]).