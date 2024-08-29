%%%-------------------------------------------------------------------
%%% @author Author_Name <Author_Email>
%%% @copyright (C) 2024, Author_Name
%%% @doc 
%%%
%%% @end
%%% Created : 26 Aug 2024 by Author_Name <Author_Email>
%%%-------------------------------------------------------------------
-module(afile_server).
-export([start/1, loop/1]).

start(Dir) -> 
    spawn(afile_server, loop, [Dir]).

loop(Dir) -> 
    receive
        {Client, list_dir} -> 
            Client ! {self(), file:list_dir(Dir)};
        {Client, {get_file, File}} -> 
            Full = filename:join(Dir, File),
            Client ! {self(), file:read_file(Full)};
        {Client, {write_file, {Name, Bytes}}} -> 
            file:write_file(Name, Bytes),
            Client ! {self(), file:read_file(Name)}
        end,
    loop(Dir).