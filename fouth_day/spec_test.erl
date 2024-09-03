-module(spec_test).
-export([start/1, start/0]).

-type onOff() :: on | off.
-spec start(any()) -> Number when 
    Number :: integer().
-spec start() -> onOff().
-export_type([onOff/0]).

start(_Any) -> 5.
start() -> on.