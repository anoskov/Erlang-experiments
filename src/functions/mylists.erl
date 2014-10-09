%%%-------------------------------------------------------------------
%%% @author FollowYourDreams
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. окт 2014 19:22
%%%-------------------------------------------------------------------
-module(mylists).
-author("FollowYourDreams").

%% API
-compile(export_all).

combine(K, V) ->
  combine(K, V, []).

combine([],[],L) ->
  lists:reverse(L);
combine([K|Ks], [V|Vs], L)->
  combine(Ks, Vs, [{K,V}|L]).