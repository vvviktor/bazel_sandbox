#include "Main/math_dll_interface.h"
#include "Main/math.h"

#include <vector>
#include <cassert>

struct MathLibArrMath {
	ArrMath obj;
};

MathLibArrMath* MathLibCreate(const void* arr) {
	//assert(arr);
	ArrMath obj(reinterpret_cast<const std::vector<int>&>(
							*reinterpret_cast<const std::vector<int>*>(arr)));
	return new MathLibArrMath{std::move(obj)};
}

void MathLibDelete(MathLibArrMath* obj) {
	delete obj;
}

int MathLibSum(const MathLibArrMath* obj) {
	return obj->obj.SumArr();
}

int MathLibMult(const MathLibArrMath* obj) {
	return obj->obj.MultArr();
}