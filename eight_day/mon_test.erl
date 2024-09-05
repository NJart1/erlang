-module(mon_test).
-export([my_spawn/3, error_test/1, on_exit/2, ref_on_exit/3, signals/0]).

my_spawn(Mod, Fun, Arg) ->
    Parent = spawn(Mod, Fun, Arg),
    spawn(fun() ->
        Ref = monitor(process, Parent),
        Parent ! run,
        receive
            {'DOWN', Ref, process, Parent, Why} ->
                io:format("~p died because of ~p~n", [Parent, Why])
        end
    end),
    Parent.

error_test(Time) ->
    receive
        run -> done
    after Time -> exit(time_shut)
    end.
ref_on_exit(Mod, Fun, Arg) ->
    Reg = spawn(Mod, Fun, Arg),
    on_exit(Reg, fun(Why) -> io:format("reason: ~p~n", [Why]), ref_on_exit(Mod, Fun, Arg) end),
    Reg.
on_exit(Pid, Fun) ->
    spawn(fun() ->
        Ref = monitor(process, Pid),
        receive
            {'DOWN', Ref, process, Pid, Why} ->
                Fun(Why)
        end
    end).
signals() ->
    receive
        exit -> exit(exit);
        normal -> normal;
        piva -> error(piva)
    end.
