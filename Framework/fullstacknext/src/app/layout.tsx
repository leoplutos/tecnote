import type { Metadata } from "next";
//import SessionProvider from "@/context/SessionProvider";
import { UserProvider } from "@/context/UserContext";
import { Inter } from 'next/font/google';
import "./globals.css";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
	title: "文件管理系统",
	description: "文件管理系统",
};

export default function RootLayout({
	children,
}: {
	children: React.ReactNode;
}) {
	return (
		<html lang="zh">
			<body className={inter.className}>
				<UserProvider>
					{/* <SessionProvider> */}
					<main>{children}</main>
					{/* </SessionProvider> */}
				</UserProvider>
			</body>
		</html>
	);
}
