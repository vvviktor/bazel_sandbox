#ifndef MAIN_MATH_H_
#define MAIN_MATH_H_

#include <vector>

class ArrMath {
public:
	ArrMath(const std::vector<int>& arr);
	int SumArr() const;
	int MultArr() const;
private:
	const std::vector<int>& arr_;
};

#endif