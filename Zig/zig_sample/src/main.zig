const std = @import("std");
// 引入第三方库String
const String = @import("string").String;
// 引入第三方库logz
const logz = @import("logz");
// 通用的内存分配器
var gpa = std.heap.GeneralPurposeAllocator(.{}){};

const User = struct {
    userName: []u8,
    password: []u8,
    email: []u8,
    active: bool,

    pub const writer = "zig-course";

    pub fn init(userName: []u8, password: []u8, email: []u8, active: bool) User {
        return User{
            .userName = userName,
            .password = password,
            .email = email,
            .active = active,
        };
    }

    pub fn print(self: *User) void {
        std.debug.print(
            \\username: {s}
            \\password: {s}
            \\email: {s}
            \\active: {}
            \\
        , .{
            self.userName,
            self.password,
            self.email,
            self.active,
        });
    }
};

const Suit = enum {
    clubs,
    spades,
    diamonds,
    hearts,

    pub fn isClubs(self: Suit) bool {
        return self == Suit.clubs;
    }
};

const name = "小明";
const passwd = "123456";
const mail = "123456@qq.com";

pub fn main() !void {
    // 通用的内存分配器
    const allocator = gpa.allocator();
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) std.testing.expect(false) catch @panic("TEST FAIL");
    }

    // 初始化日志库
    try logz.setup(allocator, .{
        .level = .Debug,
        .pool_size = 100,
        .buffer_size = 4096,
        .large_buffer_count = 8,
        .large_buffer_size = 16384,
        .output = .stdout,
        .encoding = .logfmt,
    });
    defer logz.deinit();

    // 打印日志
    logz.debug()
        .string("context", "divide")
        .float("a", 1)
        .float("b", 2).log();

    // 申请内存
    const username = try allocator.alloc(u8, 20);
    // 延后释放内存
    defer allocator.free(username);
    // @memset 是一个内存初始化函数，它会将一段内存初始化为 0
    @memset(username, 0);
    // @memcpy 是一个内存拷贝函数，它会将一个内存区域的内容拷贝到另一个内存区域
    @memcpy(username[0..name.len], name);

    const password = try allocator.alloc(u8, 20);
    defer allocator.free(password);
    @memset(password, 0);
    @memcpy(password[0..passwd.len], passwd);

    const email = try allocator.alloc(u8, 20);
    defer allocator.free(email);
    @memset(email, 0);
    @memcpy(email[0..mail.len], mail);

    var user = User.init(username, password, email, true);
    user.print();

    // 创建String
    var myString = String.init(gpa.allocator());
    defer myString.deinit();
    // 使用String
    try myString.concat("🔥 Hello!");
    _ = myString.pop();
    try myString.concat(", World 🔥");
    // 打印
    std.debug.print("{s}\n", .{myString.str()});
}
