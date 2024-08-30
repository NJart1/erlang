-module(my_tuple_to_list).
-export([tuple_to_list/1]).

% tuple_to_list({}) -> {};
% tuple_to_list(Tuple) when is_tuple(Tuple) -> 
%     funtuple(Tuple, [], 1).

% funtuple(Tuple, List, _Iterat) when tuple_size(Tuple) =:= length(List) -> lists:reverse(List);
% funtuple(Tuple, List, Iterat) -> funtuple(Tuple, [element(Iterat, Tuple) | List], Iterat + 1).

tuple_to_list({}) -> {};
tuple_to_list(Tuple) -> [element(X, Tuple) || X <- lists:seq(1, tuple_size(Tuple))].