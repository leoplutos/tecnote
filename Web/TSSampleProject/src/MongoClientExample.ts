import { getLogger } from './log/log.js';
import config from 'config';
import mongoBaseAsync from './mongodb/MongoBase.js';

// 日志
const log = getLogger();

// 主函数
async function main(): Promise<void> {
	try {
		await mongoBaseAsync();
	} catch (err) {
		throw err;
	} finally {
	}
}

// 调用 main 函数
main()
	.then(async () => {
		log.info("MongoClient运行成功");
	})
	.catch((err) => {
		log.error(err, "MongoClient发生错误");
	}).finally(async () => {
		log.flush();
	});
