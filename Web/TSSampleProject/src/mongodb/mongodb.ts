import { MongoClient, MongoClientOptions } from "mongodb";
import config from 'config';

// 数据库连接URL
const mongo_url = config.get<string>('datasource.mongo.url');
process.env.MONGODB_URI = mongo_url;

if (!process.env.MONGODB_URI) {
	throw new Error('Invalid/Missing environment variable: "MONGODB_URI"');
}

const uri = process.env.MONGODB_URI;
const options: MongoClientOptions = {};

let client: MongoClient;

if (process.env.NODE_ENV === "development") {
	// 在开发模式下，使用全局变量，以便将值在 HMR（热模块替换）导致的模块重新加载时保留
	let globalWithMongo = global as typeof globalThis & {
		_mongoClient?: MongoClient;
	};

	if (!globalWithMongo._mongoClient) {
		globalWithMongo._mongoClient = new MongoClient(uri, options);
	}
	client = globalWithMongo._mongoClient;
} else {
	// 在 production 模式下，不使用全局变量
	client = new MongoClient(uri, options);
}

// 导出模块范围的 MongoClient 使客户端可以跨函数共享
export default client;
