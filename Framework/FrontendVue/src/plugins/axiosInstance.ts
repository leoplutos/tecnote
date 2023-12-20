//axiosInstance.js
//导入axios
import axios, { type AxiosInstance } from 'axios';
import store from '../store';

//使用axios下面的create([config])方法创建axios实例，其中config参数为axios最基本的配置信息。
const axiosInstance: AxiosInstance = axios.create({
	//请求后端数据的基本地址，自定义
	//baseURL: 'http://localhost:9501',
	//使用代理，详细看vite.config.ts
	baseURL: '/springapi',
	//请求超时设置，单位ms
	timeout: 2000,
});

// request 请求拦截器
axiosInstance.interceptors.request.use(
	config => {
		if (store.state.token) {
			//在headers中设置vuex保存的token
			//config.headers['token'] = store.state.token;
			//页面刷新会导致Vue实例重新初始化，而且Vuex中的状态也会重置。使用sessionStorage避免此问题
			config.headers['token'] = window.sessionStorage.getItem("token");
		}
		return config;
	},
	error => {
		// do something with request error
		console.log(error); // for debug
		return Promise.reject(error);
	}
);

//导出我们建立的axios实例模块，ES6 export用法
export default axiosInstance;
