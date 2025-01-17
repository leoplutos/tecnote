import { getLogger } from '../log/log.js';
import { v7 as UUIDv7 } from 'uuid';
import {
	S3Client,
	S3ClientConfig,
	PutObjectCommand,
	GetObjectCommand,
	ListObjectsV2Command
} from "@aws-sdk/client-s3";

// 日志
const log = getLogger();

// AWS S3 的基础示例
async function awsS3Async(): Promise<void> {

	// 需要1: 在 Docker 中启动 Localstack
	// 需要2: 安装 awscli-local
	// 需要3: bun add @aws-sdk/client-s3
	// 需要4: 创建 本地 S3 存储桶 (mysamplebucket)
	// awslocal s3 mb s3://mysamplebucket
	// 更多示例:
	//  https://docs.aws.amazon.com/zh_cn/sdk-for-javascript/v3/developer-guide/javascript_s3_code_examples.html

	const region = process.env.AWS_REGION || 'us-east-1';
	// 保留此项以实现 LocalStack 兼容性
	const forcePathStyle = true;
	const endpoint = process.env.S3_ENDPOINT_URL || 'http://localhost:4566';
	const credentials_accessKeyId = process.env.AWS_ACCESS_KEY_ID || 'default_access_key';
	const credentials_secretAccessKey = process.env.AWS_SECRET_ACCESS_KEY || 'default_secret_key';
	// 使用 ConstructorParameters 提取 S3Client 构造函数的参数类型
	// 这里 s3ClientConfig 和 S3ClientConfig 为一样的类型
	// type s3ClientConfig = ConstructorParameters<typeof S3Client>[0];
	const option: S3ClientConfig = {
		region: region,
		forcePathStyle: forcePathStyle,
		endpoint: endpoint,
		credentials: {
			accessKeyId: credentials_accessKeyId,
			secretAccessKey: credentials_secretAccessKey,
		},
	};
	log.info(option, "AWS S3 连接信息");

	// 连接 AWS S3
	const s3Client = new S3Client(option);
	log.info("AWS S3 连接成功");

	// 库名字
	const bucketName = "mysamplebucket";
	// Key
	const key: string = UUIDv7();
	const value: string = `Hello JavaScript SDK! -> ${Date.now()}`;

	// 创建 S3 存储
	// const bucketName = `test-bucket-${Date.now()}`;
	// await s3Client.send(
	// 	new CreateBucketCommand({
	// 		Bucket: bucketName,
	// 	}),
	// );

	// 存储内容
	await s3Client.send(
		new PutObjectCommand({
			Bucket: bucketName,
			Key: key,
			Body: value,
		}),
	);
	log.info(`AWS S3 存储成功    Bucket:${bucketName}, Key:${key}, Body:${value}`);

	// 读取内容
	const { Body } = await s3Client.send(
		new GetObjectCommand({
			Bucket: bucketName,
			Key: key,
		}),
	);
	if (Body) {
		log.info(`AWS S3 读取成功    Bucket:${bucketName}, Key:${key}`);
		log.info(await Body.transformToString());
	} else {
		log.error(`AWS S3 读取失败    Bucket:${bucketName}, Key:${key}`);
	}

	// 读取KeyList
	const respList = await s3Client.send(new ListObjectsV2Command({
		Bucket: bucketName,
		MaxKeys: 10
	}));
	log.info(respList, "AWS S3 读取List成功");
}

export default awsS3Async;
