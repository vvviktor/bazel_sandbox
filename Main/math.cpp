#include "Main/math.h"

#include <numeric>
#include <functional> 

ArrMath::ArrMath(const std::vector<int>& arr) : arr_(arr) {}

int ArrMath::SumArr() const {
	return std::reduce(arr_.begin(), arr_.end(), 0);
}

int ArrMath::MultArr() const {
	return std::reduce(arr_.begin(), arr_.end(), 1, std::multiplies<int>());
}