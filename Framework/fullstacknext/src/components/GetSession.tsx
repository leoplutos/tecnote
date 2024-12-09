'use server';

import { auth } from "@/auth";

// 使用服务端组件取得当前用户信息
export async function getCurrentUser() {
	const session = await auth();
	return session;
}
