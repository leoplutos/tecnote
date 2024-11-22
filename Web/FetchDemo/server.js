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
	// fetch例子,返回client.html
	if (req.method === "GET" && (req.url === "/" || req.url === "/fetch")) {
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
		console.log(`method: ${req.method} | url: ${req.url} -> fetch请求, 流式写入开始`);
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
			}, 3); // <--- 3毫秒秒间隔，会很慢
		});
		return;
	}

	// sse例子,返回sse.html
	if (req.method === "GET" && req.url === "/sse") {
		console.log(`method: ${req.method} | url: ${req.url} -> 返回sse.html`);
		const filePath = path.join(__dirname, "sse.html");
		fs.readFile(filePath, (_, data) => {
			res.writeHead(200, { "Content-Type": "text/html" });
			res.end(data);
		});
		return;
	}

	// sse请求
	if (req.method === "GET" && req.url === "/stream") {
		console.log(`method: ${req.method} | url: ${req.url} -> SSE请求, 流式返回开始`);
		// 服务器向浏览器发送的 SSE 数据，必须是 UTF-8 编码的文本，具有如下的 HTTP 头信息
		res.writeHead(200, {
			"Content-Type": "text/event-stream",
			"Cache-Control": "no-cache",
			"Connection": "keep-alive",
			"Access-Control-Allow-Origin": '*',         // 允许跨域
		});
		// 消息内容
		// id 字段: 相当于每一条数据的编号
		// data 字段: 表示数据
		// event 字段: 表示自定义的事件类型，默认是message事件。浏览器可以用addEventListener()监听该事件
		// retry 字段: 指定浏览器重新发起连接的时间间隔

		// 设置可读流
		const filePath = path.join(__dirname, "data.json");
		const stream = fs.createReadStream(filePath, { encoding: "utf8" });
		// 一次读取 Byte （character） 流并将其发送到客户端
		stream.on("readable", function () {
			const interval = setInterval(() => {
				const chunk = stream.read(1);
				if (chunk !== null) {
					res.write("data: " + chunk + "\n\n");
				} else {
					clearInterval(interval);
					// 让客户端触发自定义事件close
					res.write("event: close\n");
					res.write("data: 数据已传输完毕\n\n");
					res.end();
				}
			}, 3); // <--- 3毫秒秒间隔，会很慢
		});
		return;
	}

	// 多文件上传例子,返回.html
	if (req.method === "GET" && req.url === "/file") {
		console.log(`method: ${req.method} | url: ${req.url} -> 返回file.html`);
		const filePath = path.join(__dirname, "file.html");
		fs.readFile(filePath, (_, data) => {
			res.writeHead(200, { "Content-Type": "text/html" });
			res.end(data);
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
	console.log(`fetch流式写入例子在 http://localhost:${PORT}/fetch`);
	console.log(`sse例子在 http://localhost:${PORT}/sse`);
	console.log(`文件上传例子在 http://localhost:${PORT}/file`);
});
