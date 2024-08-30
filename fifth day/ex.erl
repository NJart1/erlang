-module(ex).
-export([map_search_pred/2]).

map_search_pred(Map, Pred) when is_map(Map) -> 
    map_search_pred(maps:to_list(Map), Pred);
map_search_pred([], _Pred) -> [];
map_search_pred([{Key, Value} = _H | T], Pred) ->
    case Pred(Key, Value) of
        true -> {Key, Value};
        false -> map_search_pred(T, Pred)
    end.