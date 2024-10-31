import pino, { TransportMultiOptions, TransportTargetOptions } from 'pino';

// 使用ES6模块和单例模式来管理pino实例
let loggerInstance: pino.Logger | null = null;

// 日志初始化
function getLogger(): pino.Logger {
	if (!loggerInstance) {
		// 取得 NODE_ENV 环境变量
		const nodeEnv = process.env.NODE_ENV;
		if (nodeEnv === 'development') {
			// 其他，采用漂亮打印
			loggerInstance = prettyConsole();
		} else if (nodeEnv === 'production') {
			// Docker环境，采用json结构打印
			loggerInstance = jsonConsole();
		} else {
			// 其他，采用漂亮打印
			loggerInstance = prettyConsole();
		}
		console.log("pino日志初始化完成");
	}
	return loggerInstance;
}

// 采用漂亮打印
function prettyConsole(): pino.Logger {
	// 从配置文件读取
	const min_level: string = "info";
	// 配置输出
	let targetOptions: TransportTargetOptions[] = [];
	// 控制台
	targetOptions.push({ target: 'pino-pretty', });
	// 文件
	//targetOptions.push({ target: 'pino/file', options: { destination: filename, mkdir: true } });
	// 配置日志选项
	const transportOption: TransportMultiOptions = {
		targets: targetOptions,
		options: {
			colorize: true,
			singleLine: true,
			translateTime: 'yyyy-mm-dd HH:MM:ss.l',
		}
	};
	// 日志对象
	const loggerInstance = pino({
		level: min_level,
		transport: transportOption
	});
	return loggerInstance;
}

// 采用Json日志
function jsonConsole(): pino.Logger {
	// 从配置文件读取
	const min_level: string = "info";
	// 日志对象
	const loggerInstance = pino({
		level: min_level,
		base: { service_name: 'NodeGrpcService' }, // 添加基本字段
		messageKey: 'message' // 为Key改名
	});
	return loggerInstance;
}

// 公开 getLogger
export { getLogger };
