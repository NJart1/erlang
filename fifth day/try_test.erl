-module(try_test).
-export([read/1, try_test/2]).

read(File) -> 
    case file:read_file(File) of
        {ok, Bin} -> Bin;
        {error, Reason} -> error(Reason)
    end.
try_test(user, File) -> 
    try read(File)
    catch
        error:X -> {error, X}
    end;
try_test(dev, File) -> 
    try read(File)
    catch
        Y:X:StackTrace -> {File, Y, X, StackTrace}
    end.