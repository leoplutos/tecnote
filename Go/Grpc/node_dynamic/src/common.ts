import { loadPackageDefinition } from '@grpc/grpc-js';
import { loadSync, Options } from "@grpc/proto-loader";
import { PackageDefinition, ServiceClientConstructor, GrpcObject, ServiceDefinition } from '@grpc/grpc-js/build/src/make-client';

//message定义
export interface Product {
	id: string;
	name: string;
	description: string;
}

//message定义
export interface ProductId {
	value: string;
}

// 定义取得IDL服务参数
export interface ProtoServiceOptions {
	path: string;
	option: Options;
	package: string;
	service: string;
}
// 动态取得IDL服务
const getProtoService = (props: ProtoServiceOptions): ServiceDefinition => {
	//动态加载IDL文件
	const packageDefinition: PackageDefinition = loadSync(props.path, props.option);
	//加载后取得定义对象
	const grpcObj: GrpcObject = loadPackageDefinition(packageDefinition);
	//取得服务对象
	const services: GrpcObject = grpcObj[props.package] as GrpcObject;
	//取得构造器
	const constructor: ServiceClientConstructor = services[props.service] as ServiceClientConstructor;
	//从构造器中取得服务
	const { service } = constructor;
	return service;
};

// 动态取得IDL客户端
const getProtoClient = (props: ProtoServiceOptions): ServiceClientConstructor => {
	//动态加载IDL文件
	const packageDefinition: PackageDefinition = loadSync(props.path, props.option);
	//加载后取得定义对象
	const grpcObj: GrpcObject = loadPackageDefinition(packageDefinition);
	//取得服务对象
	const services: GrpcObject = grpcObj[props.package] as GrpcObject;
	//取得构造器
	const constructor: ServiceClientConstructor = services[props.service] as ServiceClientConstructor;
	return constructor;
};

//导出函数
export {
	getProtoService,
	getProtoClient,
};
