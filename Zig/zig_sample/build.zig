const std = @import("std");

pub fn build(b: *std.Build) void {
    // 标准构建目标（读取来自命令行参数的构建目标三元组）
    const target = b.standardTargetOptions(.{});
    // 标准构建模式（读取来自命令行参数的构建优化模式）
    const optimize = b.standardOptimizeOption(.{});

    // 添加一个静态库构建（使用root.zig）
    const lib = b.addStaticLibrary(.{
        .name = "zig_sample",
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    // 添加到顶级 install step 中
    b.installArtifact(lib);

    // 添加一个二进制可执行程序构建（使用main.zig）
    const exe = b.addExecutable(.{
        .name = "zig_sample",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    // 添加到顶级 install step 中
    b.installArtifact(exe);

    // 添加第三方依赖
    // 通过 dependency 函数获取到依赖
    // JakubSzark/zig-string
    const string = b.dependency("zig-string", .{
        .target = target,
        .optimize = optimize,
    });
    // karlseguin/log.zig
    const logz = b.dependency("logz", .{
        .target = target,
        .optimize = optimize,
    });
    // 将 module 添加到 exe 的 root module 中
    exe.root_module.addImport("string", string.module("string"));
    exe.root_module.addImport("logz", logz.module("logz"));

    // zig 提供了一个方便的函数允许我们直接运行构建结果
    const run_cmd = b.addRunArtifact(exe);

    // 注意：该步骤可选，显式声明运行依赖于构建
    // 这会使运行是从构建输出目录（默认为 zig-out/bin ）运行而不是构建缓存中运行
    // 不过，如果应用程序运行依赖于其他已存在的文件（例如某些 ini 配置文件）
    // 这可以确保它们正确的运行
    run_cmd.step.dependOn(b.getInstallStep());

    // 注意：此步骤可选
    // 此操作允许用户通过构建系统的命令传递参数，例如 zig build  -- arg1 arg2
    // 当前是将参数传递给运行构建结果
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // 指定一个 step 为 run（zig build run）
    const run_step = b.step("run", "Run the application");
    // 指定该 step 依赖于 run_cmd，即实际的运行
    run_step.dependOn(&run_cmd.step);

    // 指定一个 step 为 check（zig build check）
    const check_step = b.step("check", "Check if application compiles");
    // 指定该 step 依赖于 exe，并不会运行
    check_step.dependOn(&exe.step);

    // 创建用于单元测试的step（使用root.zig）
    // 这只会构建测试可执行文件但不运行它
    const lib_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    // 添加到顶级 install step 中
    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    // 创建用于单元测试的step（使用main.zig）
    // 这只会构建测试可执行文件但不运行它
    const exe_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    // 添加到顶级 install step 中
    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    // 向 'zig build --help' 菜单，为用户提供一种请求的方法
    // 运行单元测试（zig build test）
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
    test_step.dependOn(&run_exe_unit_tests.step);
}
