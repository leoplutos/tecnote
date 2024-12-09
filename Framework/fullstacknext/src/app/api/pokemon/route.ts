import { auth } from "@/auth";
import { NextResponse } from "next/server";
import { succes, fail, Result } from "@/lib/result";

export const revalidate = 60;

// 路由 [/api/pokemon] 的 GET
//export const GET = auth(async function GET(request) {
export const GET = auth(async function GET(request) {
	if (!request.auth) {
		let result: Result = fail(401, "没有访问权限");
		return NextResponse.json(result, { status: 401 });
	} else {
		//const data = await fetch('https://pokeapi.co/api/v2/pokemon/');
		//const posts = await data.json();
		let result: Result = succes("Get pokemon ok!");
		return Response.json(result);
	}
}) as any; // 添加 [as any] 解决编译错误
