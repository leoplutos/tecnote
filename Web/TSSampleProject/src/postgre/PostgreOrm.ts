import { PrismaClient, Prisma } from '@prisma/client';
import config from 'config';
import { v7 as UUIDv7 } from 'uuid';
import { getLogger } from '../log/log.js';

// 日志
const log = getLogger();

// Postgre的ORM示例
async function postgreOrmAsync(): Promise<void> {

	// 需要1:
	// bun add prisma --dev
	// bun add @prisma/client
	// 需要2: docker run -p 5432:5432 --name postgre -v $HOME/workspace/postg re_data/data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=123456 -d postgres:17.1-alpine3.20
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
	/* 需要4: 在工程根目录下运行
		// 生成 prisma/schema.prisma 和 .env 这2个文件
		bun x prisma init
		// 根据.env中定义的数据库连接生成 Prisma 模型（在schema.prisma文件中自动生成）
		bun x prisma db pull
		// 根据.env中定义的数据库连接生成 Prisma 客户端（在schema.prisma文件中自动生成）
		bun x prisma generate
	*/
	// 更多看这里:
	// https://github.com/prisma/prisma
	// https://prisma.org.cn/docs

	// prisma默认会使用 [.env] 文件中的 DATABASE_URL 定义来进行数据库连接
	// 因为笔者在 config 中已经定义所以这里进行覆盖
	const postgre_url = config.get<string>('datasource.postgre.url');
	// 覆盖 DATABASE_URL
	process.env.DATABASE_URL = postgre_url;
	log.info(`Postgre连接信息: ${process.env.DATABASE_URL}`);

	// 数据库连接
	const prisma = new PrismaClient();
	log.info("Postgre连接成功");

	let searchId = "";
	let deleteId = "";
	// 插入3条t_employee数据
	for (let i = 0; i < 3; i++) {
		// 对数据库友好的 UUID v7
		const uuidv7: string = UUIDv7();
		// 生成1到99的随机数
		const randomNumber = generateRandomNumber(1, 99);
		const employee_id = `typescript_orm_id_${randomNumber}`;
		const employe_name = `typescript_张五_${randomNumber}`;
		const employe_status = 5;
		// 使用prisma插入数据
		const employee = await prisma.t_employee.create({
			data: {
				te_pk: uuidv7,
				employee_id: employee_id,
				employe_name: employe_name,
				employe_status: employe_status
			},
		});
		log.info(employee, 't_employee表插入成功');
		switch (i) {
			case 0:
				searchId = employee_id;
				break;
			case 1:
				deleteId = employee_id;
				break;
			default:
				break;
		}
	}

	// 查询数据
	const searchResult = await prisma.t_employee.findMany({
		where: {
			employee_id: {
				equals: searchId
			}
		}
	});
	log.info(searchResult, '使用 employeeId 查询成功');

	// 更新数据
	// 生成1到99的随机数
	const randomNumber = generateRandomNumber(1, 99);
	const employe_email = `changed_${randomNumber}@exsample.com`;
	const updateResult = await prisma.t_employee.update({
		where: {
			te_pk: searchResult[0].te_pk
		},
		data: {
			employe_email: employe_email
		},
	});
	log.info(updateResult, '使用 employeeId 更新成功');

	// 删除数据
	// const deleteResult = await prisma.t_employee.delete({
	// 	where: {
	// 		te_pk: searchResult[0].te_pk
	// 	},
	// });
	const deleteResult = await prisma.t_employee.deleteMany({
		where: {
			employee_id: deleteId
		},
	});
	log.info(deleteResult, '使用 employeeId 删除成功');

	// 查询全部数据
	const allDatas = await prisma.t_employee.findMany();
	log.info(allDatas, '查询全部数据成功');

	// 自定义SQL查询
	// 使用原生SQL的方式查询, 实际项目中推荐 TypedSQL
	// 更多:
	//  https://prisma.org.cn/docs/orm/prisma-client/using-raw-sql/raw-queries
	//  https://prisma.org.cn/docs/orm/prisma-client/using-raw-sql/typedsql
	// 使用 $1 的方式只适用 PostgreSQL, 其他数据库详见官方文档
	const custQuery: any = Prisma.sql`SELECT * FROM t_employee WHERE employe_email LIKE $1`;
	const custCondi = `%@exsample.com`;
	custQuery.values = [custCondi];
	const custResult = await prisma.$queryRaw(custQuery);
	log.info(custResult, '自定义SQL查询成功');

	// 关闭连接
	await prisma.$disconnect();
}

// 生成一个 1 到 99 的随机数
function generateRandomNumber(min: number, max: number): number {
	return Math.floor(Math.random() * (max - min + 1)) + min;
}

export default postgreOrmAsync;
