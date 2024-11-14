// import { createServer } from "http";
// import { readFile, createReadStream } from "fs";
// import { join } from "path";
const http = require("http");
const fs = require("fs");
const path = require("path");

/**
 * 返回网页的简单服务器
 * 或将 JSON 从文件流式传输到客户端
 */
const server = http.createServer((req, res) => {
	// 返回client.html
	if (req.method === "GET" && req.url === "/") {
		console.log(`method: ${req.method} | url: ${req.url} -> 返回client.html`);
		const filePath = path.join(__dirname, "client.html");
		fs.readFile(filePath, (_, data) => {
			res.writeHead(200, { "Content-Type": "text/html" });
			res.end(data);
		});
		return;
	}

	// 返回json但是非常慢
	if (req.method === "GET" && req.url === "/json") {
		console.log(`method: ${req.method} | url: ${req.url} -> 流式写入开始`);
		res.writeHead(200, { "Content-Type": "application/json" });

		// 设置可读流
		const filePath = path.join(__dirname, "data.json");
		const stream = fs.createReadStream(filePath, { encoding: "utf8" });

		// 一次读取 Byte （character） 流并将其发送到客户端
		stream.on("readable", function () {
			const interval = setInterval(() => {
				const chunk = stream.read(1);
				if (chunk !== null) {
					res.write(chunk);
					// process.stdout.write(chunk);
				} else {
					clearInterval(interval);
					res.end();
				}
			}, 2); // <--- 2秒间隔，会很慢
		});
		return;
	}

	// 错误页
	res.writeHead(404, { "Content-Type": "text/plain" });
	res.end("Not Found");
});

// 绑定端口
const PORT = 9500;
server.listen(PORT, () => {
	console.log(`Server running at http://localhost:${PORT}/`);
});
