import express from 'express';
import { Express, Request, Response } from 'express';

const app: Express = express();
const PORT: number = 3300;

app.use(express.json());

app.get('/', (reueset: Request, response: Response) => {
	console.log("responsed!");
	response.status(200).send('Hello, 这是一个Express工程!');
});

app.listen(PORT, () => {
	console.log(`Express with Typescript! 服务启动在端口：${PORT}`);
});
