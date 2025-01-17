import { getLogger } from '../log/log.js';

// 日志
const log = getLogger();

// 二进制散列值和权限设计
async function bitwiseAuth(): Promise<void> {
	log.info("---------二进制散列值示例开始---------");

	// 使用 0b 开头定义一个二进制
	const a: number = 0b00000001;
	const b: number = 0b00000101;
	log.info(`a: ${num2bin(a)}`);
	log.info(`b: ${num2bin(b)}`);

	// 按位与（AND）: 如果对应的二进制位都为 1，则该二进制位为 1
	log.info(`按位与(AND): a & b -> ${num2bin(a & b)}`);
	// 按位或（OR ）: 如果对应的二进制位有一个为 1，则该二进制位为 1
	log.info(`按位或(OR ): a | b -> ${num2bin(a | b)}`);
	// 按位异或（XOR）: 如果对应的二进制位只有一个为 1，则该二进制位为 1
	log.info(`按位异或(XOR): a ^ b -> ${num2bin(a ^ b)}`);
	// 按位非（NOT）: 反转所有二进制位，即 1 转换为 0，0 转换为 1
	log.info(`按位非(NOT): ~a -> ${num2bin(~a)}`);
	// 按位左移: 将所有二进制位统一向左移动指定的位数，并在最右侧补 0
	log.info(`按位左移: a << 1 -> ${num2bin(a << 1)}`);
	// 按位右移: 将所有二进制位统一向右移动指定的位数，并拷贝最左侧的位来填充左侧
	log.info(`按位右移: a >> 1 -> ${num2bin(a >> 1)}`);
	// 无符号右移: 将所有二进制位统一向右移动指定的位数，并在最左侧补 0
	log.info(`无符号右移: a >>> 1 -> ${num2bin(a >>> 1)}`);

	log.info("---------二进制散列值示例结束---------");

	log.info("---------权限示例开始---------");

	// ■基础权限
	// 所有权限码的二进制数形式，有且只有一位值为 1，其余全部为 0
	const READ: number = 0b00000001; // 可读
	const WRITE: number = 0b00000010; // 可写
	const CREATE: number = 0b00000100; // 创建
	const DELETE: number = 0b00001000; // 删除
	// 全部权限
	const ALL: number = READ | WRITE | CREATE | DELETE;
	log.info(`ALL权限 -> ${num2bin(ALL)}`);

	// ■组合权限
	const READ_AND_WRITE = READ | WRITE;  // 可读和可写，结果为 00000011
	log.info(`可读和可写权限 -> ${num2bin(READ_AND_WRITE)}`);
	const READ_AND_CREATE = READ | CREATE;  // 可读和创建，结果为 00000101
	log.info(`可读和创建权限 -> ${num2bin(READ_AND_CREATE)}`);
	const WRITE_AND_DELETE = WRITE | DELETE;  // 可写和删除，结果为 00001010
	log.info(`可写和删除权限 -> ${num2bin(WRITE_AND_DELETE)}`);

	// ■添加权限
	// 用户1初始权限为可读和可写
	const originAuth = READ | WRITE;  // 可读和可写，结果为 00000011
	log.info(`用户1初始权限 -> ${num2bin(originAuth)}`);
	// 添加 CREATE 权限
	const auth1 = originAuth | CREATE;  // 可读和可写和创建
	log.info(`用户1添加权限后 -> ${num2bin(auth1)}`);

	// ■判断权限
	log.info(`用户1权限 -> ${num2bin(auth1)}`);
	// 判断是否包含 READ 权限
	const isRead = (auth1 & READ) === READ;
	log.info(`用户1是否有 READ 权限 -> ${isRead}`);
	// 是否包含 DELETE 权限
	const isDelete = (auth1 & DELETE) === DELETE;
	log.info(`用户1是否有 DELETE 权限 -> ${isDelete}`);

	// ■剔除权限
	const auth2 = ALL;  // 全部权限，结果为 00001111
	log.info(`用户2权限 -> ${num2bin(auth2)}`);
	// 剔除 WRITE 权限（先执行 ~ 取反，再执行 & 运算）
	const notWrite = auth2 & ~WRITE; // 输出 00001101
	log.info(`用户2剔除 WRITE 权限 -> ${num2bin(notWrite)}`);
	// 剔除 DELETE 权限
	const notDelete = auth2 & ~DELETE; // 输出 00000111
	log.info(`用户2剔除 DELETE 权限 -> ${num2bin(notDelete)}`);

	log.info("---------权限示例结束---------");
}

// Converting Decimal to Binary
function num2bin(target: number): string {
	// target >>> 0 会先把 target 的值按照无符号 32 位整数的形式进行转换
	// toString(2) 将数字转换为二进制字符串
	// padStart(8, '0') 补0,固定显示 8 位二进制数
	return (target >>> 0).toString(2).padStart(8, '0');
}

export default bitwiseAuth;
