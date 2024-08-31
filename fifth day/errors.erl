-module(errors).
-export([catch1/0]).

generate_exception(1) -> a;
generate_exception(2) -> throw(a);
generate_exception(3) -> exit(a);
generate_exception(4) -> {'EXIT', a};
generate_exception(5) -> error(a).

catch1() -> 
 %   [catch generate_exception(N) || N <- lists:seq(1, 5)].
     [catcher(N) || N <- lists:seq(1, 5)].
catcher(Val) -> 
    try generate_exception(Val) of
        N -> {ok, N}
    catch
        throw:X -> {throw, X};
        exit:X -> {exit, X};
        error:X -> {err, X}
    end.