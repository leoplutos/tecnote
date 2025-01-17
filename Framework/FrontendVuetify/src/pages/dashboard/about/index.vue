<template>
	<v-container class="mt-4 ml-4">
		<v-row class="mt-4 ml-4">
			<h2 className="mb-4">关于</h2>
		</v-row>
		<v-row class="mt-4 ml-4">
			<p>这是一个文件管理系统，提供文件上传、历史记录查看等功能。系统使用 Vue.js 和 Vuetify.js 构建，提供现代化的用户界面和流畅的使用体验。</p>
		</v-row>
	</v-container>
</template>

<script lang="ts" setup>
definePage({
	meta: {
		// 此页面[需要]登录后才可访问
		requiresAuth: true,
	},
});
</script>
