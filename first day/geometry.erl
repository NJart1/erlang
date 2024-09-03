-module(geometry).
-export([start/0, rpc_area/1, loop/1, rpc_perimetr/1]).

start() ->
    register(area, spawn(geometry, loop, [area])),
    register(perimetr, spawn(geometry, loop, [perimetr])).

rpc_perimetr(Request) ->
    perimetr ! {self(), Request},
    receive
        {perimetr, Ans} -> Ans
    end.

rpc_area(Request) ->
    area ! {self(), Request},
    receive
        {area, Ans} -> Ans
    end.

loop(area) ->
    receive
        {From, {rectangle, Width, Height}} ->
            From ! {area, area({rectangle, Width, Height})},
            loop(area);
        {From, {square, Side}} ->
            From ! {area, area({square, Side})},
            loop(area);
        {From, {triangle, Base, Height}} ->
            From ! {area, area({triangle, Base, Height})},
            loop(area);
        {From, {circle, Radius}} ->
            From ! {area, area({circle, Radius})},
            loop(area);
        {From, Undef} ->
            From ! {area, {err, Undef}},
            loop(area)
    end;
loop(perimetr) ->
    receive
        {From, {triangle, Side1, Side2, Side3}} ->
            From ! {perimetr, perimetr({triangle, Side1, Side2, Side3})},
            loop(perimetr);
        {From, {square, Side}} ->
            From ! {perimetr, perimetr({square, Side})},
            loop(perimetr);
        {From, {rectangle, Width, Long}} ->
            From ! {perimetr, perimetr({rectangle, Width, Long})},
            loop(perimetr);
        {From, {circle, Radius}} ->
            From ! {perimetr, perimetr({circle, Radius})},
            loop(perimetr);
        {From, Undef} ->
            From ! {perimetr, {err, Undef}},
            loop(perimetr)
    end.

area({rectangle, Width, Height}) -> Width * Height;
area({square, Side}) -> Side * Side;
area({triangle, Base, Height}) -> 1 / 2 * Base * Height;
area({circle, Radius}) -> math:pi() * math:pow(Radius, 2).

perimetr({triangle, Side1, Side2, Side3}) -> Side1 + Side2 + Side3;
perimetr({square, Side}) -> Side * 4;
perimetr({circle, Radius}) -> 2 * math:pi() * Radius;
perimetr({rectangle, Width, Long}) -> (Width + Long) * 2.
