import NextAuth, { User, NextAuthConfig } from "next-auth";
import Credentials from "next-auth/providers/credentials";
//import { saltAndHashPassword } from "@/lib/password";

// Auth.js 验证设定
const authOptions: NextAuthConfig = {
	// session：定义了会话管理的方式
	session: {
		// jwt 策略
		strategy: 'jwt',
		// 会话的最大有效期, 单位秒
		maxAge: 60 * 60 * 24,
	},
	// providers：定义了可以用于身份验证的方法
	providers: [
		// 使用自定义凭据认证
		Credentials({
			name: "Credentials",
			credentials: {
				userId: {},
				//email: {},
				password: {},
			},
			// 认证处理
			async authorize(credentials): Promise<User | null> {
				// 测试用户
				const users = [
					{
						userId: "admin",
						userName: "管理员",
						password: "123",
						email: "admin@example.com",
						role: 0
					},
					{
						userId: "user",
						userName: "普通用户",
						password: "123",
						email: "user@example.com",
						role: 1
					},
				];
				// 将明文密码转为暗文
				// const pwHash = saltAndHashPassword(credentials.password as string);
				// 账号密码验证逻辑
				// user = await getUserFromDb(credentials.email, pwHash);
				// 查询用户信息
				const user = users.find(
					(user) =>
						user.userId === credentials.userId &&
						user.password === credentials.password
				);

				if (user) {
					const result: User = {
						id: user.userId,
						name: user.userName,
						email: user.email,
						userId: user.userId,
						role: user.role,
					};
					return result;
				} else {
					return null;
				}
			},
		}),
	],
	// 添加逻辑以保护您的路由。这将阻止用户访问仪表板页面，除非他们已登录
	callbacks: {
		// 验证回调
		// 在此验证用户是否已经登录，控制页面是否可以访问
		async authorized({ auth, request: { nextUrl } }) {
			const isLoggedIn = !!auth?.user;
			const isOnDashboard = nextUrl.pathname.startsWith('/dashboard');
			const isOnApi = nextUrl.pathname.startsWith('/api');
			if (isOnApi) {
				return true;
			}
			if (isOnDashboard) {
				if (isLoggedIn) {
					return true;
				}
				// 将未经身份验证的用户重定向到登录页面
				return false;
				//return Response.redirect(new URL('/login', nextUrl));
			} else if (isLoggedIn) {
				return true;
				//return Response.redirect(new URL('/dashboard', nextUrl));
			}
			return true;
		},
		// 每当创建 JSON Web 令牌时（即在登录时），都会调用此回调
		async jwt({ token, user }) {
			if (user) {
				token.userId = user.userId;
				token.role = user.role;
			}
			return token;
		},
		// 每当检查 session 时，都会调用该回调
		async session({ session, token }) {
			if (token && session.user) {
				session.user.userId = token.userId as string;
				session.user.role = token.role as number;
			}
			return session;
		},
	},
	// pages：定义了各种身份验证相关页面的路径
	pages: {
		// 在拦截用户登录后会重定向到该路径
		signIn: "/login",
	},
};

// Auth.js 验证导出
export const { handlers, auth, signIn, signOut } = NextAuth(authOptions);
