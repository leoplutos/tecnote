import { auth } from "@/auth";

export default auth;

// 保护 dashboard 页面
export const config = {
	// https://nextjs.org/docs/app/building-your-application/routing/middleware#matcher
	matcher: ['/((?!api|_next/static|_next/image|.*\\.png$|.*\\.svg$).*)'],
	//matcher: ['/dashboard/:path*']
};
