<template>
	<div>
		<h1>你应该不会看到这里</h1>
	</div>
</template>

<script lang="ts" setup>
definePage({
	// 访问此页面会重定向到 /login
	redirect: '/login',
	meta: {
		// 此页面[不需要]登录即可访问
		requiresAuth: false,
		// 指定使用src/layouts/loginLayout.vue, 如不指定则使用default.vue
		layout: "loginLayout"
	},
});
</script>
