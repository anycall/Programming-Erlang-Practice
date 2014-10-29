-module(area_server).
-export([loop/0,start/0,area/2]).

start() ->
	spawn(area_server,loop,[]).

area(Pid,What) ->
	rpc(Pid,What).


loop() -> 
	receive 
		{From,{rectangle,Width,Ht}} ->
			From ! {self(),Width*Ht},
			loop();
		{From,{square,Side}} ->
			From ! {self(),Side*Side},
			loop();
		{From,{circle,R}} ->
			From ! {self(),3.14159 *R*R },
			loop();
		{From,Other} ->
			From ! {error,Other},
			loop()
	end.

rpc(Pid,Request) ->
	Pid ! {self(),Request},
	receive 
		{Pid,Response} -> 
			Response
	end.