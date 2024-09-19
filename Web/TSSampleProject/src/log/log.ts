import config from 'config';
import pino, { TransportMultiOptions, TransportTargetOptions } from 'pino';

// 使用ES6模块和单例模式来管理pino实例
let loggerInstance: pino.Logger | null = null;

// 日志初始化
function getLogger(): pino.Logger {
	if (!loggerInstance) {
		// 从配置文件读取
		const min_level: string = config.get<string>('pinolog.min_level');
		const output: string = config.get<string>('pinolog.output');
		const filename: string = config.get<string>('pinolog.filename');

		// 配置输出
		let targetOptions: TransportTargetOptions[] = [];
		if (output === "console") {
			// 控制台
			targetOptions.push({ target: 'pino-pretty', });
		} else {
			// 文件
			targetOptions.push({ target: 'pino/file', options: { destination: filename, mkdir: true } });
		}
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
		loggerInstance = pino({
			level: min_level,
			transport: transportOption
		});
		console.log(`pino日志级别:${min_level}`);
		console.log("pino日志初始化完成");
	}
	return loggerInstance;
}

// 公开 getLogger
export { getLogger };
