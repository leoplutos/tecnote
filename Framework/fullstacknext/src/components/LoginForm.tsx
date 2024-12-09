'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Result } from "@/lib/result";
import { getCurrentUser } from "@/components/GetSession";
import { useUser, UserInfo } from "@/context/UserContext";
import { Loading } from "@/components/ui/loading";

export default function LoginForm() {
	// useState 是 React 提供的一个钩子（Hook），用于在函数组件中添加状态
	// 它接受一个初始值（在这里是空字符串 ''），并返回一个包含两个元素的数组
	// 当前状态值（username） 更新状态的函数（setUsername）
	const [username, setUsername] = useState('');
	const [password, setPassword] = useState('');
	const [error, setError] = useState('');
	const [isLoading, setIsLoading] = useState(false);
	const router = useRouter();
	// 自定义用户信息
	const { userInfo, setUserInfo } = useUser();

	const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
		// 阻止浏览器的默认行为
		event.preventDefault();
		setError('');
		setIsLoading(true);

		try {
			// 请求后端API
			//const response = await fetch('http://localhost:3000/api/login', {
			const response = await fetch('/api/login', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json;charset=UTF-8',
				},
				body: JSON.stringify({
					userId: username,
					password: password,
				}),
			});
			if (response.ok) {
				// 取得请求结果
				const result: Result = await response.json();
				if (result?.code === 200) {
					// 登录成功
					// console.log('登录成功:', result);
					// 取得用户信息
					// console.log('登录成功:', result.data);
					// 取得用户信息并且设置到 [UserContext]
					const session = await getCurrentUser();
					if (session?.user) {
						const user: UserInfo = {
							id: session.user.userId ?? null,
							name: session.user.name ?? null,
							email: session.user.email ?? null,
							role: session.user.role ?? null,
						};
						setUserInfo(user);
						// 跳转到仪表板
						router.push('/dashboard');
					} else {
						setError('取得用户信息失败，请重试！');
					}
				} else {
					// 登录失败
					setError('登录失败，请重试！');
				}
			} else {
				// 登录失败
				setError('请求失败，请重试！');
			}
		} catch (error) {
			console.error(error);
			setError('登录过程中发生错误，请重试！');
		} finally {
			setIsLoading(false);
		}

		/*
		try {
			// const formData = new FormData(event.currentTarget);
			//const formData = new FormData();
			//formData.append('userId', username);
			//formData.append('password', password);
			const result = await signInAction(username, password);
			if (result?.error) {
				setError(result.error);
			} else if (result?.ok) {
				// 登录成功，重定向到仪表板或首页
				router.push('/dashboard');
			} else {
				// 登录失败
				setError(result.error || '登录失败，请重试！');
			}
		} catch (error) {
			// console.error('登录错误:', error);
			setError('登录过程中发生错误，请重试！');
		}
		*/
	};

	return (
		<form onSubmit={handleSubmit} className="space-y-4 bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
			<Loading isLoading={isLoading} />
			<div>
				<Label htmlFor="username">用户名</Label>
				<Input
					id="username"
					type="text"
					value={username}
					onChange={(e) => setUsername(e.target.value)}
					required
				/>
			</div>
			<div>
				<Label htmlFor="password">密码</Label>
				<Input
					id="password"
					type="password"
					value={password}
					onChange={(e) => setPassword(e.target.value)}
					required
				/>
			</div>
			{error && <p className="text-red-500">{error}</p>}
			<Button type="submit" className="w-full" disabled={isLoading}>
				{isLoading ? '登录中...' : '登录'}
			</Button>
		</form>
	);
}
