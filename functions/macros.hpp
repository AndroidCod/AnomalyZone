#ifndef AZ_MACROS_COMMON
#define AZ_MACROS_COMMON

#define DEBUG_MODE
//#define TRACE_MODE   <-- put ONLY for a single file
#include "macros_debug.hpp"

#include "..\defines.hpp"

#define POS_X(pos) ((pos) select 0)
#define POS_Y(pos) ((pos) select 1)
#define POS_Z(pos) ((pos) select 2)

#define RECT_X(rect) POS_X(rect)
#define RECT_Y(rect) POS_Y(rect)
#define RECT_W(rect) ((rect) select 2)
#define RECT_H(rect) ((rect) select 3)


#define CLAMP(a, low, high) (((a) max (low)) min (high))

#define __GET(v, i) 	((v) select (i))
#define __SET(v, i, a) 	((v) set[(i), (a)])

#define FLOOR_10(a) ((floor((a)/10))*10)

#endif

