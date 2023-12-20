<script lang="ts">
import { ref, onMounted } from 'vue';
import { type AxiosResponse, HttpStatusCode } from 'axios';
import axiosInstance from "../plugins/axiosInstance";
import { useRouter } from "vue-router";;
import { useStore } from 'vuex';
import { ElMessage } from 'element-plus';

export default {
	setup() {
		//定义数据
		const loginForm = ref({
			loginName: 'admin',
			password: '123'
		});
		const router = useRouter();
		const store = useStore();
		//定义登录的方法
		const methods = {
			//async/await 实现请求同步功能
			async doLogin() {
				// 访问后端api进行登录验证
				await axiosInstance({
					url: '/login',
					method: 'post',
					data: {
						userId: loginForm.value.loginName,
						password: loginForm.value.password
					}
				}).then((response: AxiosResponse) => {
					const resultCode: number = response.data.code;
					const resultMessage: string = response.data.message;
					const resultData = response.data.data;
					if (resultCode == HttpStatusCode.Ok) {
						//提示登录成功消息
						ElMessage(resultMessage);
						//将resultData（token）保存到vuex的全局状态中
						store.commit('setToken', resultData);
						//页面跳转至 /todo 页
						router.push({ path: "/todo" });
					} else {
						ElMessage.error(resultMessage);
						//抹除vuex的全局状态
						store.commit('removeToken');
					}
				}).catch((error: any) => {
					console.log(error);
					ElMessage.error(error);
					//抹除vuex的全局状态
					store.commit('removeToken');
				});
			},
		};
		// DOM挂载后的钩子
		onMounted(() => {
		});
		// 定义点击事件处理函数
		const doLogin = () => {
			methods.doLogin();
		};
		return {
			loginForm, doLogin
		};
	}
};

</script>

<template>
	<body id="login-page">
		<el-form class="login-container" label-position="left" label-width="0px">
			<h3 class="login_title">系统登录</h3>
			<el-form-item>
				<el-input type="text" v-model="loginForm.loginName" auto-complete="off" placeholder="账号"></el-input>
			</el-form-item>
			<el-form-item>
				<el-input type="password" v-model="loginForm.password" auto-complete="off" placeholder="密码" show-password
					@keyup.enter="doLogin"></el-input>
			</el-form-item>
			<el-form-item style="width: 100%">
				<el-button type="primary" style="width: 100%;  border: none" round @click.stop="doLogin">登录</el-button>
			</el-form-item>
		</el-form>
	</body>
</template>

<style scoped>
#login-page {
	/*background: url("../assets/img/bg.jpg") no-repeat;*/
	background-position: center;
	height: 100%;
	width: 100%;
	background-size: cover;
	position: fixed;
}

body {
	margin: 0px;
}

.login-container {
	border-radius: 15px;
	background-clip: padding-box;
	margin: 90px auto;
	width: 350px;
	padding: 35px 35px 15px 35px;
	background: #fff;
	border: 1px solid #eaeaea;
	box-shadow: 0 0 25px #cac6c6;
}

.login_title {
	margin: 0px auto 40px auto;
	text-align: center;
	color: #505458;
}
</style>
