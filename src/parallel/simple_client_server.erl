%%%-------------------------------------------------------------------
%%% @author FollowYourDreams
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. окт 2014 18:31
%%%-------------------------------------------------------------------
-module(simple_client_server).
-author("FollowYourDreams").

%% API
-export([start/0, area/2]).

start() ->
  spawn(fun loop/0).

area(Pid, What) ->
  rpc(Pid, What).

rpc(Pid, Request) ->
  Pid ! {self(), Request},
  receive
    {Pid, Response} ->
      Response
  end.

loop() ->
  receive
    {From, {rectangle, Width, Height}} ->
      From ! {self(), Width * Height},
      loop();
    {From, {circle, R}} ->
      From ! {self(), 3.14159 * R * R},
      loop();
    {From,Other} ->
      From ! {self(), {error, Other}},
      loop()
  end.
