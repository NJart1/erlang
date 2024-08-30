-module(geometry).  
-export([area/1, perimetr/1]). 

area({rectangle, Width, Height}) -> Width * Height;
area({square, Side})             -> Side * Side;
area({triangle, Base, Height}) -> 1 / 2 * Base * Height;
area({circle, Radius}) -> math:pi() * math:pow(Radius,2).

perimetr({triangle, Side1, Side2, Side3}) -> Side1 + Side2 +Side3;
perimetr({square, Side}) -> Side * 4;
perimetr({circle, Radius}) -> 2 * math:pi() * Radius;
perimetr({rectangle, Width, Long}) -> (Width +Long) * 2.