import { fileURLToPath, URL } from 'node:url';

import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';

// https://cn.vitejs.dev/config/
export default defineConfig(({ command, mode, isSsrBuild, isPreview }) => {
	if (command === 'serve') {
		// dev 开发环境配置（开发环境下 command 的值为 serve，vite dev 和 vite serve 是 vite 的别名）
		return {
			plugins: [
				vue(),
			],
			server: {
				host: '0.0.0.0',
				port: 9500,//自定义端口
				proxy: {
					// 本地开发环境通过代理实现跨域，生产环境使用 nginx 转发
					"/springapi": {
						// 后端为SpringBoot：这里设定为127.0.0.1和localhost都可以
						// 后端为Sanic：这里只能设定为127.0.0.1
						target: "http://127.0.0.1:9501",
						changeOrigin: true, //必须要开启跨域
						// 当调用以 localhost:9500/springapi 开头的接口时，都会自动代理到 http://localhost:9501/springapi
						rewrite: (path) => path.replace(/^\/springapi/, '')
					},
				},
			},
			resolve: {
				alias: {
					'@': fileURLToPath(new URL('./src', import.meta.url))
				}
			}
		};
	} else {
		// command === 'build'
		// build 生产环境配置
		return {
			plugins: [
				vue(),
			],
			server: {
				host: '0.0.0.0',
				port: 9500,//自定义端口
				proxy: {
					// 生产环境使用 nginx 转发
					"/springapi": {},
				},
			},
			resolve: {
				alias: {
					'@': fileURLToPath(new URL('./src', import.meta.url))
				}
			}
		};
	}
});
