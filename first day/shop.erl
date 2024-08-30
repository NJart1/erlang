-module(shop).
-import(lists, [sum/1, map/2]).
-export([total/1]).

total(List) -> sum(map(fun({Item, Num}) -> shop_1:cost(Item) * Num end, List)).