import type { NextConfig } from "next";

const nextConfig: NextConfig = {
	// 严格模式
	reactStrictMode: true,
	// 仅包含必要的文件/依赖项, 可用于在 Docker 容器中自托管
	output: "standalone",
	// experimental: {
	// 	externalDir: true,
	// },
	// 服务端扩展依赖
	// serverExternalPackages: ['pino', 'pino-pretty'],
	// 设定重定向
	async redirects() {
		return [
			{
				source: '/',
				destination: '/login',
				permanent: false, // 将其设置为 true 则代表 301 重定向，false 代表 307 临时重定向
			},
		];
	},
};

export default nextConfig;
