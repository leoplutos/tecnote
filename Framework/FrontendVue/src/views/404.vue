<script lang="ts">
import { useRouter } from "vue-router";;

export default {
	setup() {
		const router = useRouter();
		// 定义点击事件处理函数
		const gotoLogin = () => {
			//页面跳转至 /login 页
			router.push({ path: "/login" });
		};
		return {
			gotoLogin
		};
	}
};
</script>

<template>
	<el-result title="404" sub-title="未找到请求资源">
		<template #icon>
			<el-image src="https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png" />
		</template>
		<template #extra>
			<el-button type="primary" @click="gotoLogin">Back</el-button>
		</template>
	</el-result>
</template>

