#include <iostream>
#include <vector>
#include <cstring>
#include <stdexcept>

#include "Main/math_dll_interface.h"

int main(int argc, char** argv) {	
	if (argc == 1) {
		std::cout << "Usage: sum_numbers <num1> <num2> <...> <numN>\n";		
	} else {
		++argv;		
		if (argc == 2 && memcmp(*argv, "-version", 9) == 0) {			
			printf("Build is done using MINGW toolchain with GCC version %d.%d.%d at %s %s\n",
          			__GNUC__,
          			__GNUC_MINOR__,
          			__GNUC_PATCHLEVEL__,
          			__TIME__,
          			__DATE__);
			return 0;
		}
		std::vector<int> input;
		input.reserve(argc - 1);
		try {
			while (--argc) {						
				input.push_back(std::stoi(*argv++));			
			}
		} catch (const std::invalid_argument& e) {
			std::cout << "Non digit input is not allowed!\n";
			return 0;	
		}		
		MathLibArrMath* arr_math = MathLibCreate(&input);				
		std::cout << "Sum == " << MathLibSum(arr_math)
				  << "\nProduct == " << MathLibMult(arr_math) 
				  << "\nDone!\n";
		MathLibDelete(arr_math);		
	}	
	return 0;
}