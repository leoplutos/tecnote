import { getLogger } from './log/log.js';
import awsS3Async from './aws/AwsS3.js';
import awsDynamoDBAsync from './aws/AwsDynamoDB.js';

// 日志
const log = getLogger();

// 主函数
async function main(): Promise<void> {
	try {
		log.info("开始运行AWSExample");
		//await awsS3Async();
		await awsDynamoDBAsync();
	} catch (err) {
		throw err;
	} finally {
	}
}

// 调用 main 函数
main()
	.then(async () => {
		log.info("AWSExample运行成功");
	})
	.catch((err) => {
		log.error(err, "AWSExample发生错误");
	}).finally(async () => {
		log.flush();
	});
