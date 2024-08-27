//返回类型的接口

export interface Result {
	code: number,
	message: string,
	data: any;
};

export function succes(data: any): Result {
	let result: Result = {
		code: 200,
		message: "success",
		data: data
	};
	return result;
}

export function fail(code: number, message: string): Result {
	let result: Result = {
		code: code,
		message: message,
		data: null
	};
	return result;
}
