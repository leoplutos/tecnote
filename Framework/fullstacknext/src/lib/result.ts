// 返回类型的接口

export interface Result {
	code: number,
	message?: string,
	data?: any;
};

export function succes(data: any): Result {
	const result = setResult({
		data: data
	});
	return result;
}

export function fail(code: number, message: string): Result {
	const result = setResult({
		code: code,
		message: message
	});
	return result;
}

interface SetResultParams {
	code?: number;
	message?: string;
	data?: any;
}

const setResult = (params: SetResultParams = {}): Result => {
	return {
		code: params.code || 200,
		message: params.message || "success",
		data: params.data || null,
	};
};
