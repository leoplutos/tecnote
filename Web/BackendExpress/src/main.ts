// 导入npm的express库
import express, { Express, Request, Response } from 'npm:express';

// Express对象
const app: Express = express();
// 服务地址
// 服务端口:9500
const PORT: number = 9500;

// 开启json支持
app.use(express.json());

// 路由 /
app.get('/', (reueset: Request, response: Response) => {
	console.log(`method: ${reueset.method} | url: ${reueset.url} -> 访问根目录`);
	response.status(200).send('Hello, 这是一个 Express 工程!');
});

app.listen(PORT, () => {
	console.log(`后端服务 Express 已开启  端口:${PORT}/`);
});
