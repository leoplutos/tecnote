<!--默认布局-->
<template>
	<v-no-ssr>
		<!-- 内部的所有内容仅在客户端渲染。 -->
		<v-app>
			<!--脚组件(放在上面是为了使用屏幕的全宽度,如果放在下面它将只使用剩余的宽带,也就是会在右侧)-->
			<AppFooter />
			<!--头组件-->
			<AppHeader />
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
