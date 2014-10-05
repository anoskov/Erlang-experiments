%%%-------------------------------------------------------------------
%%% @author FollowYourDreams
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. окт 2014 19:02
%%%-------------------------------------------------------------------
-module(road).
-author("FollowYourDreams").

%% API
-compile(export_all).

%%% Нахождение оптимального пути

main() ->
  File = "road.txt",
  {ok, Bin} = file:read_file(File),
  optimal_path(parse_map(Bin)).

%% Считываем и группируем карту

parse_map(Bin) when is_binary(Bin) ->
  parse_map(binary_to_list(Bin));
parse_map(Str) when is_list(Str) ->
  Values = [list_to_integer(X) || X <- string:tokens(Str, "\r\n\t ")],
  group_vals(Values, []).

group_vals([], Acc) -> lists:reverse(Acc);
group_vals([A,B,X|Rest], Acc) ->
  group_vals(Rest, [{A,B,X} | Acc]).

%% Аккумулируем

shortest_step({A,B,X}, {{DistA, PathA}, {DistB, PathB}}) ->
  OptA1 = {DistA + A, [{a, A}|PathA]},
  OptA2 = {DistB + B + X, [{x, X}, {b, B}|PathB]},
  OptB1 = {DistB + B,[{b, B}|PathB]},
  OptB2 = {DistA + A + X, [{x, X}, {a, A}|PathA]},
  {erlang:min(OptA1, OptA2), erlang:min(OptB1, OptB2)}.

%% Вычисляем оптимальный путь

optimal_path(Map) ->
  {A, B} = lists:foldl(fun shortest_step/2, {{0,[]}, {0, []}}, Map),
  element(2, erlang:min(A, B)).