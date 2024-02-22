# Defines the C++ settings that tell Bazel precisely how to construct C++
# commands. This is unique to C++ toolchains: other languages don't require
# anything like this.
#
# See
# https://bazel.build/docs/cc-toolchain-config-reference
# for all the gory details.
#
# This file is more about C++-specific toolchain configuration than how to
# declare toolchains and match them to platforms. It's important if you want to
# write your own custom C++ toolchains. But if you want to write toolchains for
# other languages or figure out how to select toolchains for custom CPU types,
# OSes, etc., the BUILD file is much more interesting.

load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "artifact_name_pattern",
    "tool_path",
    "feature",
    "flag_group",
    "flag_set",
)

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name)
    ctx.actions.write(out, "executable")

    # path to external MINGW Compiler (e.g: "C:/toolchains/TDM-GCC-64")
    MINGW_PATH = ctx.var.get("MINGW_PATH")

    # MINGW Compiler Version (e.g: "10.3.0")
    GCC_VERSION = ctx.var.get("GCC_VERSION")

    dbg_feature = feature(
        name = "dbg",
        flag_sets = [
            flag_set(
                actions = [ACTION_NAMES.c_compile, ACTION_NAMES.cpp_compile],
                flag_groups = [flag_group(flags = ["-g", "-Og"])],
            ),
        ],
    )

    opt_feature = feature(
        name = "opt",
        flag_sets = [
            flag_set(
                actions = [ACTION_NAMES.c_compile, ACTION_NAMES.cpp_compile],
                flag_groups = [flag_group(flags = [
                    "-g0",
                    "-O3",
                    "-DNDEBUG",
                    "-ffunction-sections",
                    "-fdata-sections",
                ])],
            ),
            flag_set(
                actions = all_link_actions,
                flag_groups = [flag_group(flags = ["-Wl,--gc-sections"])],
            ),
        ],
    )

    features = [
        dbg_feature,
        opt_feature,
    ]

    return [
        cc_common.create_cc_toolchain_config_info(
            ctx = ctx,
            toolchain_identifier = "mingw-toolchain",
            host_system_name = "nothing",
            target_system_name = "nothing",
            target_cpu = "x86_64",
            target_libc = "nothing",
            cc_target_os = "windows",
            compiler = "gcc",
            abi_version = "gcc-" + GCC_VERSION,
            abi_libc_version = "nothing",
            tool_paths = [
                tool_path(
                    name = "ar",
                    path = MINGW_PATH + "/bin/ar",
                ),
                tool_path(
                    name = "cpp",
                    path = MINGW_PATH + "/bin/cpp",
                ),
                tool_path(
                    name = "gcc",
                    path = MINGW_PATH + "/bin/g++",
                ),
                tool_path(
                    name = "gcov",
                    path = MINGW_PATH + "/bin/gcov",
                ),
                tool_path(
                    name = "ld",
                    path = MINGW_PATH + "/bin/ld",
                ),
                tool_path(
                    name = "nm",
                    path = MINGW_PATH + "/bin/nm",
                ),
                tool_path(
                    name = "objdump",
                    path = MINGW_PATH + "/bin/objdump",
                ),
                tool_path(
                    name = "strip",
                    path = MINGW_PATH + "/bin/strip",
                ),
            ],
            cxx_builtin_include_directories = [
                MINGW_PATH + "/include",
                MINGW_PATH + "/lib/gcc/x86_64-w64-mingw32/" + GCC_VERSION + "/include-fixed",
                MINGW_PATH + "/lib/gcc/x86_64-w64-mingw32/" + GCC_VERSION + "/include",
                MINGW_PATH + "/lib/gcc/x86_64-w64-mingw32/" + GCC_VERSION + "/install-tools/include",
                MINGW_PATH + "/x86_64-w64-mingw32/include",
            ],
            features = features,
            artifact_name_patterns = [
                artifact_name_pattern(
                    category_name = "executable",
                    prefix = "",
                    extension = ".exe",
                ),
            artifact_name_pattern(
                    category_name = "dynamic_library",
                    prefix = "lib",
                    extension = ".dll",
                )
            ],
        ),
        DefaultInfo(
            executable = out,
        ),
    ]

mingw_cc_toolchain_config = rule(
    implementation = _impl,
    provides = [CcToolchainConfigInfo],
    executable = True,
)