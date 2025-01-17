import { getLogger } from '../log/log.js';
import client from "./mongodb.js";

// 日志
const log = getLogger();

interface MusicInfo {
	Artist: string;
	SongTitle: string;
	info: {
		AlbumTitle: string;
		Awards: number;
		SearchKey: string[];
	};
}

// MongoDB的基础示例
async function mongoBaseAsync(): Promise<void> {

	// 需要1:
	// bun add mongodb
	// 需要2:
	/*
		docker run -d \
		-p 27017:27017 \
		-e MONGO_INITDB_ROOT_USERNAME=mongoroot \
		-e MONGO_INITDB_ROOT_PASSWORD=123456 \
		-v $HOME/workspace/mongo_data/data/db:/data/db \
		-v $HOME/workspace/mongo_data/data/configdb:/data/configdb \
		--network mongo_network \
		--name mongo_container \
		mongo:8-noble
	*/
	// 需要3: 提前建立好 数据库 [mongo_sample] Collection [Music]
	// 更多看这里:
	// https://github.com/mongodb/node-mongodb-native

	log.info(`MongoDB连接信息: ${process.env.MONGODB_URI}`);

	// 数据库 [mongo_sample]
	const db = client.db("mongo_sample");
	// 表名 [Music]
	const tableName = "Music";
	const collection = db.collection(tableName);
	// 插入数据
	const insertValue1: MusicInfo = {
		Artist: "周杰伦",
		SongTitle: "爱在西元前",
		info: {
			AlbumTitle: "范特西",
			Awards: 1,
			SearchKey: ["爱", "西元"]
		},
	};
	const insertValue2: MusicInfo = {
		Artist: "周杰伦",
		SongTitle: "简单爱",
		info: {
			AlbumTitle: "范特西",
			Awards: 2,
			SearchKey: ["简单", "爱"]
		},
	};
	const insertValue3: MusicInfo = {
		Artist: "周杰伦",
		SongTitle: "忍者",
		info: {
			AlbumTitle: "范特西",
			Awards: 3,
			SearchKey: ["忍", "者"]
		},
	};
	const insertResult = await collection.insertMany([insertValue1, insertValue2, insertValue3]);
	// const insertResult = await collection.insertOne(insertValue1);
	log.info(insertResult, `表[${tableName}]数据插入成功`);

	// 更新数据
	const updateValue: MusicInfo = {
		Artist: "周杰伦",
		SongTitle: "忍者",
		info: {
			AlbumTitle: "范特西",
			Awards: 7,
			SearchKey: ["忍", "者", "忍者"]
		},
	};
	//const updateResult = await collection.updateOne({ SongTitle: "忍者" }, { $set: updateValue });
	const updateResult = await collection.updateMany({ SongTitle: "忍者" }, { $set: updateValue });
	log.info(updateResult, `表[${tableName}]数据更新成功`);

	// 删除数据
	const deleteResult = await collection.deleteMany({ SongTitle: "爱在西元前" });
	log.info(deleteResult, `表[${tableName}]数据删除成功`);

	// 查询数据
	const findResult = await collection
		.find({})
		// .find({ SongTitle: "简单爱" })
		.sort({ metacritic: -1 })
		.limit(100)
		.toArray();
	log.info(findResult, `表[${tableName}]数据查询成功`);

	// 关闭数据库连接
	await client.close();
}

export default mongoBaseAsync;
