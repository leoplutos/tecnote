import { Session, User } from "next-auth";
import { succes, fail } from "@/lib/result";
import { signIn, auth } from "@/auth";

// 路由 [/api/login] 的 POST
export async function POST(request: Request) {
	console.log("Login开始");
	// 取得 JSON 请求数据
	const body = await request.json();
	// 解构 JSON 请求数据
	const { userId, password } = body;
	if (!userId || !password) {
		console.log("Login失败");
		return Response.json(fail(401, "用户名和密码不能为空!"));
	}
	try {
		// 使用 Auth.js 进行认证
		const signResult = await signIn("credentials", {
			userId: userId,
			password: password,
			// 设定不自动重定向, 自己控制
			redirect: false,
		});
		// 检查登录是否成功
		if (signResult?.error) {
			console.log("Login失败");
			return Response.json(fail(401, "用户名或密码错误!"));
		}
	} catch (error) {
		console.log("Login失败");
		if ((error as { type: string; }).type === 'CredentialsSignin') {
			return Response.json(fail(401, "用户名或密码错误!"));
		} else {
			return Response.json(fail(500, "认证逻辑出错"));
		}
	}
	let result = null;
	// // 认证成功后取得认证信息
	// const session: Session | null = await auth();
	// if (session?.user) {
	// 	const user: User = session?.user;
	// 	result = {
	// 		userId: user.userId,
	// 		name: user.name,
	// 		email: user.email,
	// 		role: user.role,
	// 	};
	// }
	console.log("Login结束");
	return Response.json(succes(result));
}
