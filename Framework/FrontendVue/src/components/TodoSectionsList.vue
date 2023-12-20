<script lang="ts">
export default {
	props: {
		headline: String,
		studyChild: Object,
	},
};
</script>

<template>
	<!-- studyChild后面加的感叹号意思是告诉TS您已检查并确定此元素存在，不然报错 -->
	<div style="text-align: -webkit-center">
		<el-card shadow="hover" class="box-card" style="width: 300px;text-align: center;" v-show="studyChild!.length">
			<template #header>
				<div class="card-header">
					<span style="color: #6b778c;font-size: 26px;font-weight: 600;">{{ headline }}</span>
				</div>
			</template>
			<div v-for="element in studyChild" :key="element.todoId" class="text item">
				<img :src="element.image" style="height: 20px;" />
				<span>{{ element.todoName }}</span>
				<input type="checkbox" v-model="element.studied" />
			</div>
		</el-card>
	</div>
	<br />
</template>

<style scoped>
h1 {
	margin: 0;
	text-align: center;
}
</style>
