<script lang="ts">
import { ref, onMounted, computed } from 'vue';
import TodoSectionsList from "./TodoSectionsList.vue";
import { type AxiosResponse } from 'axios';
import axiosInstance from "../plugins/axiosInstance";

export default {
	components: { TodoSectionsList },
	setup() {
		//定义数据
		const langlists = ref([] as any[]);
		//定义获取数据的方法
		const methods = {
			//async/await 实现请求同步功能
			async refreshData() {
				// 访问后端api取得数据
				await axiosInstance({
					url: '/todo/getAll',
					method: 'post'
				}).then((response: AxiosResponse) => {
					//const resultCode: number = response.data.code;
					//const resultMessage: string = response.data.message;
					const resultData = response.data.data;
					//console.log(resultCode);
					//console.log(resultMessage);
					//console.log(resultData);
					langlists.value = resultData;
				}).catch((error: any) => {
					console.log(error);
				});
			},
		};
		// DOM挂载后的钩子
		onMounted(() => {
			methods.refreshData();
		});
		// computed计算属性传入一个回调函数
		const filters = computed(() => {
			return {
				beforeStudy: langlists.value.filter((item) => !item.studied),
				afterStudy: langlists.value.filter((item) => item.studied),
			};
		});

		return {
			langlists, filters
		};
	}
};
</script>

<template>
	<TodoSectionsList headline="未学习" :studyChild="filters.beforeStudy"></TodoSectionsList>
	<TodoSectionsList headline="已学习" :studyChild="filters.afterStudy"></TodoSectionsList>
</template>
