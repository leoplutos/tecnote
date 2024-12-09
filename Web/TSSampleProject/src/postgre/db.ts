import config from 'config';
import pg from 'pg';
import { getLogger } from '../log/log.js';

// 日志
const log = getLogger();

// 从 config 文件夹 读取数据库连接信息
// const datasource_host = config.get<string>('datasource.postgre.host');
// const datasource_port = config.get<number>('datasource.postgre.port');
// const datasource_database = config.get<string>('datasource.postgre.database');
// const datasource_user = config.get<string>('datasource.postgre.user');
// const datasource_password = config.get<string>('datasource.postgre.password');
const postgre_url = config.get<string>('datasource.postgre.url');

// 数据库连接信息
const poolConfig: pg.PoolConfig = {
	// 连接设定
	// host: datasource_host,
	// port: datasource_port,
	// database: datasource_database,
	// user: datasource_user,
	// password: datasource_password,
	connectionString: postgre_url,
	// 连接池设定
	max: 20,
	idleTimeoutMillis: 30000,
	connectionTimeoutMillis: 2000,
};
log.info(poolConfig, 'db.ts -> Postgre连接信息: ');

// Postgre数据库连接池
const pool: pg.Pool = new pg.Pool(poolConfig);
log.info('db.ts -> Postgre连接成功');

// 采用回调方式执行SQL
export const queryCallback = (queryText: string, params: any, callback: (err: Error, result: pg.QueryResult<any>) => void) => {
	return pool.query(queryText, params, callback);
};

// 采用异步方式执行SQL
export const queryAsync = async (queryText: string, params: any) => {
	const start: number = Date.now();
	const res: pg.QueryResult<any> = await pool.query(queryText, params);
	const duration: number = Date.now() - start;
	log.debug({ queryText, params, duration, rows: res.rowCount }, 'db.ts -> 已执行SQL: ');
	return res;
};

// 取得DB客户端
// 取得的客户端必须 client.release()
// export const getClient = async () => {
// 	return pool.connect();
// };

// 取得DB客户端
export const closePool = async () => {
	await pool.end();
	log.info('Postgre连接池已关闭');
};
