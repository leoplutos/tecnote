import { succes } from "@/lib/result";
import { signOut } from "@/auth";

// 路由 [/api/logout] 的 POST
export async function POST(_request: Request) {
	console.log("Logout开始");
	// 默认情况下，用户在注销后会被重定向到当前页面。你可以通过设置一个相对路径的 'redirectTo' 选项来覆盖这个行为。
	await signOut({
		// 设定不自动重定向, 自己控制
		redirect: false,
	});
	console.log("Logout结束");
	return Response.json(succes("ok"));
}
