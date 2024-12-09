'use client';

import React, { createContext, useContext, useState } from 'react';

// 定义用户信息的接口
export interface UserInfo {
	id?: string;
	name?: string | null;
	email?: string | null;
	role?: number | null;
}

// 定义上下文的类型
interface UserContextType {
	userInfo: UserInfo;
	setUserInfo: React.Dispatch<React.SetStateAction<UserInfo>>;
}

// 创建上下文并指定初始值为 undefined
const UserContext = createContext<UserContextType | undefined>(undefined);

// 定义用户Provider用来共享用户信息
export const UserProvider = ({ children }: { children: React.ReactNode; }) => {
	// 初始用户信息
	const [userInfo, setUserInfo] = useState<UserInfo>({});

	return (
		<UserContext.Provider value={{ userInfo, setUserInfo }}>
			{children}
		</UserContext.Provider>
	);
};

// 自定义 Hook 用于访问用户上下文
export const useUser = () => {
	const context = useContext(UserContext);
	if (!context) {
		throw new Error("useUser 必须在 UserProvider 中使用");
	}
	return context;
};
