import { defineStore } from 'pinia';
import { ref } from 'vue';

type LoginParams = {
	userid: string;
	password: string;
};

type UserInfo = {
	userid?: string;
	username?: string;
	email?: string;
	role?: number;
};

// 使用Pinia集中管理用户的登录状态
export const useAuthStore = defineStore('auth', () => {
	// 用户信息
	const user = ref<UserInfo>({});
	// 是否登录
	const isLoggedIn = ref(false);

	// 定义登录函数
	const login = async ({ userid, password }: LoginParams) => {
		// 这里应该调用实际的登录 API
		// 这是示例实现
		if (userid === 'admin' && password === '123') {
			user.value = {
				userid: userid,
				username: '管理员',
				email: 'admin@example.com',
				role: 0
			};
			isLoggedIn.value = true;
		} else if (userid === 'user' && password === '123') {
			user.value = {
				userid: userid,
				username: '普通用户',
				email: 'user@example.com',
				role: 1
			};
			isLoggedIn.value = true;
		} else {
			throw new Error('登录失败，请重试！');
		}
	};

	// 定义登出函数
	const logout = async () => {
		user.value = {};
		isLoggedIn.value = false;
	};

	// 返回状态
	return {
		user,
		isLoggedIn,
		login,
		logout
	};
}, {
	// 使用 pinia-plugin-persistedstate 插件 在 sessionStorage 中储存用户状态
	persist: {
		storage: sessionStorage,
	},
});
