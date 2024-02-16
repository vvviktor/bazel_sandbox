#ifndef MAIN_MATH_IMPORT_DEFS_H_
#define MAIN_MATH_IMPORT_DEFS_H_

#ifdef MATH_DLL
	#define MATH_DLL_EXPORT_DECL __declspec(dllexport)
#else
	#define MATH_DLL_EXPORT_DECL __declspec(dllimport)
#endif
	
#define MATH_DLL_EXPORT extern "C" MATH_DLL_EXPORT_DECL

#endif