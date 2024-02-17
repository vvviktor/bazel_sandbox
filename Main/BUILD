# //Main/BUILD

DLL_HDRS = ["math_import_defs.h", "math_dll_interface.h"]

cc_binary(
    name = "sum_numbers_mingw",
    srcs = ["main.cpp"] + DLL_HDRS,
    dynamic_deps = [":math_d_shared"]
)

cc_shared_library(
    name = "math_d_shared",
    deps = [":math_dll_interface"]
)

cc_library(
    name = "math_dll_interface",
    srcs = ["math_dll_interface.cpp"],
    hdrs = DLL_HDRS,
    deps = [":math"],
    defines = ["MATH_DLL"]
)

cc_library(
    name = "math",
    srcs = ["math.cpp"],
    hdrs = ["math.h"],
    copts = ["-std=c++17"]
)