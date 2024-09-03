-module(aftertest).
-export([start/0, flush_buffer/0]).

start() -> spawn(aftertest, flush_buffer, []).
flush_buffer() ->
    receive
        _Any ->
            flush_buffer()
    after 0 ->
        true
    end.