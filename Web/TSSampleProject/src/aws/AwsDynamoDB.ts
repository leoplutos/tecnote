import { getLogger } from '../log/log.js';
import {
	DynamoDBClient, DynamoDBClientConfig
} from "@aws-sdk/client-dynamodb";
import {
	DeleteCommand,
	DynamoDBDocumentClient,
	PutCommand,
	UpdateCommand,
	paginateQuery,
} from "@aws-sdk/lib-dynamodb";

// 日志
const log = getLogger();
// const log = (msg) => console.log(`[SCENARIO] ${msg}`);

// AWS DynamoDB 的基础示例
async function awsDynamoDBAsync(): Promise<void> {

	// 需要1: 在 Docker 中启动 Localstack
	// 需要2: 安装 awscli-local
	// 需要3:
	// bun add @aws-sdk/client-dynamodb
	// bun add @aws-sdk/lib-dynamodb
	// 需要4: 建表 表名[Music] 分区键[Artist] 排序键[SongTitle] 最大吞吐量[10个读取容量单位]和[5个写入容量单位]
	/*
	awslocal dynamodb create-table \
	--table-name Music \
	--attribute-definitions \
		AttributeName=Artist,AttributeType=S \
		AttributeName=SongTitle,AttributeType=S \
	--key-schema \
		AttributeName=Artist,KeyType=HASH \
		AttributeName=SongTitle,KeyType=RANGE \
	--provisioned-throughput \
		ReadCapacityUnits=10,WriteCapacityUnits=5 \
	--table-class STANDARD
	*/
	// DynamoDB 是具有无模式特性的, 所以可以插入未定义的列
	// 更多示例:
	//  https://docs.aws.amazon.com/zh_cn/sdk-for-javascript/v3/developer-guide/javascript_dynamodb_code_examples.html

	const region = process.env.AWS_REGION || 'us-east-1';
	// 保留此项以实现 LocalStack 兼容性
	const forcePathStyle = true;
	const endpoint = process.env.DynamoDB_ENDPOINT_URL || 'http://localhost:4566';
	const credentials_accessKeyId = process.env.AWS_ACCESS_KEY_ID || 'default_access_key';
	const credentials_secretAccessKey = process.env.AWS_SECRET_ACCESS_KEY || 'default_secret_key';

	// 使用 ConstructorParameters 提取 DynamoDBClient 构造函数的参数类型
	// 这里 dBClientConfig 和 DynamoDBClientConfig 为一样的类型
	// type dBClientConfig = ConstructorParameters<typeof DynamoDBClient>[0];
	const option: DynamoDBClientConfig = {
		region: region,
		//forcePathStyle: forcePathStyle,
		endpoint: endpoint,
		credentials: {
			accessKeyId: credentials_accessKeyId,
			secretAccessKey: credentials_secretAccessKey,
		},
	};
	log.info(option, "AWS DynamoDB 连接信息");

	// 连接 AWS DynamoDB
	const dbClient = new DynamoDBClient(option);
	const docClient = DynamoDBDocumentClient.from(dbClient);
	log.info("AWS DynamoDB 连接成功");

	const tableName = "Music";
	// 创建 Music 表
	/*
	const createTableCommand = new CreateTableCommand({
		TableName: tableName,
		AttributeDefinitions: [
			{
				AttributeName: "Artist",
				// https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.LowLevelAPI.html#Programming.LowLevelAPI.DataTypeDescriptors
				AttributeType: "S",
			},
			{ AttributeName: "SongTitle", AttributeType: "S" },
		],
		// https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/best-practices.html
		KeySchema: [
			{ AttributeName: "Artist", KeyType: "HASH" },
			{ AttributeName: "SongTitle", KeyType: "RANGE" },
		],
		ProvisionedThroughput: {
			ReadCapacityUnits: 10,
			WriteCapacityUnits: 5
		},
		TableClass: TableClass.STANDARD
	});
	log.info(`创建表[${tableName}]中...`);
	const createTableResponse = await dbClient.send(createTableCommand);
	log.info(`创建表[${tableName}]完成: ${JSON.stringify(createTableResponse.TableDescription)}`);
	log.info(`等待表[${tableName}]状态可用....`);
	await waitUntilTableExists({ client: dbClient, maxWaitTime: 60 }, { TableName: tableName });
	log.info(`表[${tableName}]已可用`);
	*/

	// 添加数据
	await docClient.send(new PutCommand({
		TableName: tableName,
		Item: {
			Artist: "周杰伦",
			SongTitle: "爱在西元前",
			info: {
				AlbumTitle: "范特西",
				Awards: 1,
				SearchKey: ["爱", "西元"]
			},
		},
	}));
	log.info(`表[${tableName}]数据插入成功`);
	await docClient.send(new PutCommand({
		TableName: tableName,
		Item: {
			Artist: "周杰伦",
			SongTitle: "简单爱",
			info: {
				AlbumTitle: "范特西",
				Awards: 2,
				SearchKey: ["简单", "爱"]
			},
		},
	}));
	log.info(`表[${tableName}]数据插入成功`);
	await docClient.send(new PutCommand({
		TableName: tableName,
		Item: {
			Artist: "周杰伦",
			SongTitle: "忍者",
			info: {
				AlbumTitle: "范特西",
				Awards: 3,
				SearchKey: ["忍", "者"]
			},
		},
	}));
	log.info(`表[${tableName}]数据插入成功`);

	// 更新数据
	const updateResponse = await docClient.send(new UpdateCommand({
		TableName: tableName,
		Key: {
			Artist: "周杰伦",
			SongTitle: "忍者",
		},
		// https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.UpdateExpressions.html
		// UpdateExpression: "set #i.#g = list_append(#i.#g, :vals)",
		// ExpressionAttributeNames: { "#i": "info", "#g": "genres" },
		// ExpressionAttributeValues: {
		// 	":vals": ["Comedy"],
		// },
		UpdateExpression: "SET info.Awards = :a, info.SearchKey = :s",
		ExpressionAttributeValues: {
			":a": 7,
			":s": ["忍", "者", "忍者"],
		},
		ReturnValues: "ALL_NEW",
	}));
	log.info(`表[${tableName}]数据更新成功: ${JSON.stringify(updateResponse.Attributes)}`);

	// 删除数据
	await docClient.send(new DeleteCommand({
		TableName: tableName,
		Key: {
			Artist: "周杰伦",
			SongTitle: "爱在西元前",
		},
	}));
	log.info(`表[${tableName}]数据删除成功 -> SongTitle: "爱在西元前"`);

	// 查询数据
	const paginatedQuery = paginateQuery(
		{ client: docClient },
		{
			TableName: tableName,
			// https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Query.html#Query.KeyConditionExpressions
			KeyConditionExpression: "#a = :a",
			ExpressionAttributeNames: { "#a": "Artist" },
			ExpressionAttributeValues: { ":a": "周杰伦" },
			ConsistentRead: true,
		},
	);
	const datas = [];
	for await (const page of paginatedQuery) {
		if (page.Items) {
			datas.push(...page.Items);
		}
	}
	// log.info(`表[${tableName}]数据查询成功: ${datas.map((m) => m.SongTitle).join(", ")}`);
	log.info(datas, `表[${tableName}]数据查询成功`);
}

export default awsDynamoDBAsync;
