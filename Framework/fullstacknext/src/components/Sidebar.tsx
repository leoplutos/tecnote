'use client';

import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import { ScrollArea } from "@/components/ui/scroll-area";
import { UploadIcon as FileUpload, History, Users, Info, Menu } from 'lucide-react';
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useEffect, useState } from "react";
import { useUser } from "@/context/UserContext";
import { UserRole } from "@/lib/const";

export function Sidebar() {
	// 自定义用户信息
	const { userInfo, setUserInfo } = useUser();
	// 画面加载状态
	const [isLoaded, setIsLoaded] = useState(false);
	// 是否是管理员
	const [isAdmin, setIsAdmin] = useState(false);

	// 检查加载状态
	useEffect(() => {
		if (userInfo) {
			// console.log(`用户ID：${userInfo.id}`);
			// console.log(`用户姓名：${userInfo.name}`);
			// console.log(`用户邮箱：${userInfo.email}`);
			// console.log(`用户角色：${userInfo.role}`);
			if (userInfo.role === UserRole.ADMIN) {
				// 管理员
				setIsAdmin(true);
			} else {
				// 普通用户
				setIsAdmin(false);
			}
			setIsLoaded(true);
		}
	}, [userInfo]);

	const pathname = usePathname();
	const [isCollapsed, setIsCollapsed] = useState(false);

	const routes = [
		{
			label: "文件上传",
			icon: FileUpload,
			href: "/dashboard/upload",
			color: "text-blue-500",
		},
		{
			label: "上传历史",
			icon: History,
			href: "/dashboard/history",
			color: "text-green-500",
		},
		...(isAdmin
			? [
				{
					label: "用户管理",
					icon: Users,
					href: "/dashboard/users",
					color: "text-violet-500",
				},
			]
			: []),
		{
			label: "关于",
			icon: Info,
			href: "/dashboard/about",
			color: "text-orange-500",
		},
	];

	return (
		<div className={cn(
			"relative h-full border-r bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60",
			isCollapsed ? "w-16" : "w-60"
		)}>
			<div className="flex h-16 items-center justify-between border-b bg-background px-3">
				<span className={cn(
					"font-semibold tracking-tight",
					isCollapsed ? "hidden" : "block"
				)}>
					菜单
				</span>
				<Button
					onClick={() => setIsCollapsed(!isCollapsed)}
					variant="ghost"
					className="h-9 w-9 p-0"
				>
					<Menu className="h-4 w-4" />
					<span className="sr-only">切换侧边栏</span>
				</Button>
			</div>
			<ScrollArea className="h-[calc(100vh-4rem)]">
				<div className="space-y-1 p-2">
					{routes.map((route) => (
						<Link
							key={route.href}
							href={route.href}
							className={cn(
								"flex items-center gap-x-2 rounded-lg px-3 py-2 text-sm font-medium transition-all hover:bg-accent hover:text-accent-foreground",
								pathname === route.href && "bg-accent text-accent-foreground",
								isCollapsed ? "justify-center px-2" : ""
							)}
						>
							<route.icon className={cn("h-4 w-4", route.color)} />
							{!isCollapsed && <span>{route.label}</span>}
						</Link>
					))}
				</div>
			</ScrollArea>
		</div>
	);
}
