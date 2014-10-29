-module(geometry1).
-export([test/0,area/1,perimeter/1]).

test() ->
	12 = area({rectangle,3,4}),
	144 = area({square,12}),
	6.0 = area({righttriangle,3,4}),
	9 = perimeter({rectangle,3,3,3}),
	16 = perimeter({square,4}),
	31.415926 = perimeter({circle,5}),
	test_worked.
	
area({rectangle,Width,Height}) -> Width * Height;
area({square,Side}) -> Side * Side;
area({circle,Radius}) -> 3.14159265357 * Radius * Radius;
area({righttriangle,Width,Height}) -> Width * Height /2.


perimeter({rectangle,A,B,C}) -> A+B+C;
perimeter({square,Side}) -> Side*4;
perimeter({circle,Radius}) -> 2 * 3.1415926 * Radius.
