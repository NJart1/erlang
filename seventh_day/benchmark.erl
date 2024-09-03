-module(benchmark).
-export([test1/0, wait/0, ring/2, ring_loop/0, final_loop/1]).
test1() ->
    Max = erlang:system_info(process_limit),
    io:format("Maximum allowed processes: ~p~n", [Max]),
    statistics(wall_clock),
    statistics(runtime),
    Max_list = lists:seq(1, Max - 10000),
    L = [{X, spawn(fun() -> wait() end)} || X <- Max_list],
    {_, Time1} = statistics(runtime),
    {_, Time2} = statistics(wall_clock),
    lists:foreach(fun({_X, Pid}) -> Pid ! die end, L),
    U1 = Time1 * 1000 / Max,
    U2 = Time2 * 1000 / Max,
    io:format(
        "Process spawn time=~p (~p) microseconds~n",
        [U1, U2]
    ).

wait() ->
    receive
        die -> void
    end.


ring(N, Loops) -> 
    Lists = [list_to_atom(atom_to_list(proc_) ++ integer_to_list(X)) || X <- lists:seq(1,N)],
    Final_list = lists:delete(lists:last(Lists), Lists),
    lists:foreach(fun(X) -> register(X, spawn(benchmark, ring_loop, [])) end ,Final_list),
    register(lists:last(Lists), spawn(benchmark, final_loop, [Loops])),
    statistics(wall_clock),
    statistics(runtime),
    proc_1 ! {self(), 1, 0},

    receive
        {_Life, Loops} -> io:format("Done ~p loops~n", [Loops])
    after 1000 -> err
    end,
    {_, Time1} = statistics(runtime),
    {_, Time2} = statistics(wall_clock),
    U1 = Time1 * 1000 / N,
    U2 = Time2 * 1000 / N,
    io:format(
        "Packet travel time=~p (~p) microseconds~n",
        [U1, U2]
    ).

ring_loop() -> 
    receive
        {Pid ,Life, Loops} ->
            To = list_to_atom(atom_to_list(proc_) ++ integer_to_list(Life + 1)),
            To ! {Pid, Life + 1, Loops},
            Pid ! {Life, Loops},
            ring_loop();
        die -> void
    end.
final_loop(Final) -> 
    receive
        {Pid, Life, Loops} when Final =:= Loops ->
            [list_to_atom(atom_to_list(proc_) ++ integer_to_list(X)) ! die || X <- lists:seq(1, Life)],
            Pid ! {Life, Loops};
        {Pid, _Life, Loops} ->
            proc_1 ! {Pid, 1, Loops + 1},
            final_loop(Final)
    end.







