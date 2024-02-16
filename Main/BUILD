# //Main/BUILD

DLL_HDRS = ["math_import_defs.h", "math_dll_interface.h"]

cc_binary(
    name = "sum_numbers_mingw",
    srcs = ["main.cpp"],
    deps = [":math_d_shared"]
)

cc_import(
    name = "math_d_shared",
    hdrs = DLL_HDRS,
    shared_library = ":libmath_d.dll"
)

cc_binary(
    name = "libmath_d.dll",
    srcs = ["math_dll_interface.cpp"] + DLL_HDRS,
    deps = [":math"],
    defines = ["MATH_DLL"],
    linkshared = 1
)

cc_library(
    name = "math",
    srcs = ["math.cpp"],
    hdrs = ["math.h"],
    copts = ["-std=c++17"]
)