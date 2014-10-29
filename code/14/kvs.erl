-module(kvs).
-export([start/0,store/2,lookup/1]).

%%-spec kvs:start()->true
%%启动服务器，它将创建一个注册名为kvs的服务器

%%-spec kvs:store(Key,Value) -> true
%%关联Key和Value

%%-spec kvs:lookup(Key) -> {ok,Value}| undefined
%%查询Key的值，如果Key带有关联值就返回{ok,Value}，否则返回undefined

start() -> register(kvs,spawn(fun()->loop() end)).
store(Key,Value) -> rpc({store,Key,Value}).
lookup(Key) -> rpc({lookup,Key}).

rpc(Q) ->
	kvs ! {self(),Q},
	receive
		{kvs,Reply} ->
			Reply
	end.

loop() ->
	receive
		{From ,{store,Key,Value}} ->
			put(Key,{ok,Value}),
			From ! {kvs,true},
			loop();
		{From ,{lookup,Key}} ->
			From ! {kvs,get(Key)},
			loop()
	end.
