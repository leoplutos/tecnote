'use client';

import { useEffect, useState } from "react";
//import { Session } from "next-auth";
import { useRouter } from 'next/navigation';
import { Bell, Settings, User, LogOut } from 'lucide-react';
// import { useSession } from "next-auth/react";
import { usePathname } from "next/navigation";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Result } from "@/lib/result";
import { useUser, UserInfo } from "@/context/UserContext";
import { getCurrentUser } from "@/components/GetSession";

export function Header() {
	const router = useRouter();
	// 取得登录用户信息
	//const { data: session, status } = useSession();
	// 自定义用户信息
	const { userInfo, setUserInfo } = useUser();
	//const [session, setSession] = useState<Session>();

	// 检查加载状态
	useEffect(() => {
		const fetchUser = async () => {
			// 通过服务端组件取得当前用户信息
			const session = await getCurrentUser();
			if (session) {
				if (session?.user) {
					const user: UserInfo = {
						id: session.user.userId ?? null,
						name: session.user.name ?? null,
						email: session.user.email ?? null,
						role: session.user.role ?? null,
					};
					setUserInfo(user);
				}
			};
		};
		if (!userInfo === null || Object.keys(userInfo).length === 0) {
			fetchUser();
		}
	}, []);

	// 检查加载状态
	/*
	useEffect(() => {
		const fetchData = async () => {
			try {
				const response = await fetch('/api/auth/session', {
					method: 'GET',
				});
				if (response.ok) {
					const data = await response.json();
					if (data) {
						// const { user, expires } = data;
						// const { name, email, userId, role } = user;
						// console.log(`用户姓名：${name}`);
						// console.log(`用户邮箱：${email}`);
						// console.log(`用户ID：${userId}`);
						// console.log(`用户角色：${role}`);
						// console.log(`会话过期时间：${expires}`);
						setSession(data);
						setIsLoaded(true);
					}
				} else {
					//console.error('获取会话信息失败，状态码：', response.status);
					setIsLoaded(false);
				}
			} catch (error) {
				//console.error('Error fetching data:', error);
				setIsLoaded(false);
			}
		};
		//fetchData();
	}, []);
	*/

	// 制作面包屑
	const pathname = usePathname();
	const breadcrumbs = pathname
		.split('/')
		.filter(Boolean)
		.map((segment) => ({
			label: segment.charAt(0).toUpperCase() + segment.slice(1),
			href: `/${segment}`,
		}));

	// 退出登录
	const handleLogout = async () => {
		try {
			const response = await fetch('/api/logout', {
				method: 'POST',
			});
			// 取得请求结果
			const result: Result = await response.json();
			if (result.code === 200) {
				// 初始用户信息
				setUserInfo({});
				// 退出成功
				router.push('/login');
			} else {
				console.error(result);
			}
		} catch (error) {
			console.error(error);
		}
	};

	return (
		<header className="fixed top-0 left-0 right-0 z-50 flex h-16 items-center border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
			<div className="flex flex-1 items-center justify-between px-4">
				<div className="flex items-center gap-4">
					<span className="font-semibold tracking-tight">文件管理系统</span>
					<nav className="flex items-center space-x-1">
						{breadcrumbs.map((crumb, index) => (
							<div key={crumb.href} className="flex items-center">
								{index > 0 && <span className="mx-2 text-muted-foreground">/</span>}
								<span className="text-sm font-medium">
									{crumb.label === 'Dashboard' ? '仪表板' : crumb.label === 'Upload' ? '文件上传' : crumb.label === 'History' ? '上传历史' : crumb.label === 'Users' ? '用户管理' : crumb.label === 'About' ? '关于' : crumb.label}
								</span>
							</div>
						))}
					</nav>
				</div>
				<div className="flex items-center gap-2">
					<Button variant="ghost" size="icon" className="h-9 w-9" title="通知">
						<Bell className="h-4 w-4" />
						<span className="sr-only">通知</span>
					</Button>
					<DropdownMenu>
						<DropdownMenuTrigger asChild>
							<Button variant="ghost" className="h-9 gap-2 px-2">
								<Avatar className="h-7 w-7">
									{/* <AvatarImage src="/next.svg" alt={session?.user?.name || "未登录"} /> */}
									<AvatarImage src="/next.svg" alt={userInfo?.name || "未登录"} />
									<AvatarFallback>无图像</AvatarFallback>
								</Avatar>
								<span className="hidden text-sm font-medium md:inline-block">
									{
										/*
										isLoaded ? (
											<div>欢迎, {session?.user?.name}&nbsp;({session?.user?.email})</div>
										) : null
										*/
										<div>欢迎, {userInfo?.name}&nbsp;({userInfo?.email})</div>
									}
								</span>
							</Button>
						</DropdownMenuTrigger>
						<DropdownMenuContent align="end" className="w-56">
							<DropdownMenuLabel>我的账户</DropdownMenuLabel>
							<DropdownMenuSeparator />
							<DropdownMenuItem>
								<User className="mr-2 h-4 w-4" />
								个人信息
							</DropdownMenuItem>
							<DropdownMenuItem>
								<Settings className="mr-2 h-4 w-4" />
								设置
							</DropdownMenuItem>
							<DropdownMenuSeparator />
							<DropdownMenuItem onClick={handleLogout}>
								<LogOut className="mr-2 h-4 w-4" />
								退出登录
							</DropdownMenuItem>
						</DropdownMenuContent>
					</DropdownMenu>
				</div>
			</div>
		</header>
	);
}
