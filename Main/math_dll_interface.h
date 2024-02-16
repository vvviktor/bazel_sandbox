#ifndef MAIN_MATH_DLL_INTERFACE_H_
#define MAIN_MATH_DLL_INTERFACE_H_

#include "Main/math_import_defs.h"

class MathLibArrMath;

MATH_DLL_EXPORT MathLibArrMath* MathLibCreate(const void* arr);
MATH_DLL_EXPORT void MathLibDelete(MathLibArrMath* obj);
MATH_DLL_EXPORT int MathLibSum(const MathLibArrMath* obj);
MATH_DLL_EXPORT int MathLibMult(const MathLibArrMath* obj);

#endif
