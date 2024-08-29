-module(misc_lib).
-export([qsort/1]).

qsort([]) -> [];
qsort([Pivot|T]) ->
    qsort([X || X <- T, X < Pivot])
        ++ [Pivot] ++
    qsort([X || X <- T, X >= Pivot]).