import { getLogger } from './log/log.js';
import { closePool } from "./postgre/db.js";
import postgreBaseAsync from "./postgre/PostgreBase.js";
import postgreOrmAsync from "./postgre/PostgreOrm.js";

// 日志
const log = getLogger();

// 主函数
async function main(): Promise<void> {
	try {
		log.info("开始运行PostgreBase");
		// 调用Postgre基础实例
		await postgreBaseAsync();
		await closePool();
		log.info("===================");
		log.info("开始运行PostgreOrm");
		// 调用PostgreORM实例
		await postgreOrmAsync();
	} catch (err) {
		throw err;
	} finally {
	}
}

// 调用 main 函数
main()
	.then(async () => {
		log.info("PostgreClient运行成功");
	})
	.catch((err) => {
		log.error(err, "PostgreClient发生错误");
	}).finally(async () => {
		log.flush();
	});
