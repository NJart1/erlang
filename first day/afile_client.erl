%%%-------------------------------------------------------------------
%%% @author Author_Name <Author_Email>
%%% @copyright (C) 2024, Author_Name
%%% @doc 
%%%
%%% @end
%%% Created : 26 Aug 2024 by Author_Name <Author_Email>
%%%-------------------------------------------------------------------
-module(afile_client).
-export([ls/1, get_file/2, put_file/3]).

ls(Server) -> 
    Server ! {self(), list_dir},
    receive
        {Server, FileList} -> 
            FileList
    end.

get_file(Server, File) -> 
    Server ! {self(), {get_file, File}},
    receive
        {Server, Content} -> 
            Content
    end.
put_file(Server, Name, Bytes) -> 
    Server ! {self(), {write_file, {Name, Bytes}}},
    receive
        {Server, Content} -> Content
    end.