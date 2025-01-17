<!--登录布局-->
<template>
	<v-no-ssr>
		<!-- 内部的所有内容仅在客户端渲染。 -->
		<v-app>
			<!--主内容-->
			<v-main>
				<router-view />
			</v-main>
		</v-app>
	</v-no-ssr>
</template>

<script lang="ts" setup>
//
</script>
