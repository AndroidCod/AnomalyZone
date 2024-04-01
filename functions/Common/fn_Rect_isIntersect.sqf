
//#define TRACE_MODE
#include "..\macros.hpp"

params ["_rectA", "_rectB"];

if (((RECT_Y(_rectB) + RECT_H(_rectB)) < RECT_Y(_rectA)) or {(RECT_Y(_rectB) > (RECT_Y(_rectA) + RECT_H(_rectA)))} ) exitWith {false};

if (((RECT_X(_rectB)+RECT_W(_rectB)) < RECT_X(_rectA)) or {RECT_X(_rectB) > (RECT_X(_rectA)+RECT_W(_rectA))} ) exitWith {false};
	
true
