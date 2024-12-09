import { QueryResult } from 'pg';
import { v7 as UUIDv7 } from 'uuid';
import { getLogger } from '../log/log.js';
import { queryAsync } from './db.js';

// 日志
const log = getLogger();

// Postgre的基础示例
async function postgreBaseAsync(): Promise<void> {

	// 需要1:
	// bun add pg
	// bun add --dev @types/pg
	// 需要2: docker run -p 5432:5432 --name postgre -v $HOME/workspace/postgre_data/data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=123456 -d postgres:17.1-alpine3.20
	// 需要3: 建表
	/*
		CREATE TABLE t_employee (
			te_pk UUID NOT NULL UNIQUE,
			employee_id TEXT NOT NULL,
			employe_name TEXT,
			employe_email TEXT,
			employe_status SMALLINT,
			PRIMARY KEY(te_pk)
		);
	*/
	// 更多看这里:
	// https://github.com/brianc/node-postgres
	// https://node-postgres.com/

	// 插入3条t_employee数据
	for (let i = 0; i < 3; i++) {
		// 对数据库友好的 UUID v7
		const uuidv7: string = UUIDv7();
		// 生成1到99的随机数
		const randomNumber = generateRandomNumber(1, 99);
		const employee_id = `typescript_base_id_${randomNumber}`;
		const employe_name = `typescript_张五_${randomNumber}`;
		const employe_status = 5;
		const sql = "INSERT INTO t_employee (te_pk, employee_id, employe_name, employe_status) VALUES ($1::uuid, $2::text, $3::text, $4::smallint)";
		const params = [uuidv7, employee_id, employe_name, employe_status];
		await queryAsync(sql, params);
		log.info(params, "t_employee表插入成功");
	}

	// 查询t_employee所有数据
	const result: QueryResult<any> = await queryAsync("SELECT * FROM t_employee", []);
	log.info("t_employee表查询成功");
	for (const row of result.rows) {
		log.info(row);
	}

	// return new Promise((resolve) => {
	// 	resolve();
	// });
	// return Promise.resolve();
}

// 生成一个 1 到 99 的随机数
function generateRandomNumber(min: number, max: number): number {
	return Math.floor(Math.random() * (max - min + 1)) + min;
}

export default postgreBaseAsync;
