import NextAuth, { DefaultSession } from "next-auth";

// Auth.js 模块增强
declare module "next-auth" {
	interface User {
		userId: string;
		role: number;
	}

	interface Session {
		user: {
			userId: string;
			role: number;
		} & DefaultSession["user"];
	}
}
