-module(b).
-export([testa/1]).

-spec testa(spec_test:onOff()) -> spec_test:onOff().

testa(on) -> off;
testa(off) -> on.