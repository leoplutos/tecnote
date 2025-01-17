<template>
	<LoginForm />
</template>

<script lang="ts" setup>
definePage({
	meta: {
		// 此页面[不需要]登录即可访问
		requiresAuth: false,
		// 指定使用src/layouts/loginLayout.vue, 如不指定则使用default.vue
		layout: "loginLayout"
	},
});
</script>
