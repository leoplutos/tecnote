<!--头组件和侧边栏-->
<template>
	<v-app-bar prominent class="d-flex justify-start">
		<!--三横线-->
		<v-app-bar-nav-icon variant="text" @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
		<div class="d-flex justify-start">
			<!--题头-->
			<v-toolbar-title class="font-weight-black ml-2">文件管理系统</v-toolbar-title>
			<!--面包屑导航-->
			<v-breadcrumbs :items="breadcrumbs" class="pa-0 ml-8">
				<template v-slot:prepend>
					<v-icon icon="mdi-home" size="small"></v-icon>
				</template>
				<template v-slot:divider>
					<v-icon icon="mdi-chevron-right"></v-icon>
				</template>
				<template v-slot:title="{ item }">
					<v-breadcrumbs-item :to="item.href" :disabled="item.disabled"
						:class="{ 'disabled-breadcrumb': item.disabled }">
						{{ item.title === 'Dashboard' ? '仪表板' : item.title === 'Upload' ? '文件上传' : item.title ===
							'History' ? '上传历史' : item.title === 'Users' ? '用户管理' : item.title === 'About' ? '关于' :
								item.title }}
					</v-breadcrumbs-item>
				</template>
			</v-breadcrumbs>
		</div>
		<!--空垫片-->
		<v-spacer></v-spacer>
		<!--右上角区域-->
		<template v-if="$vuetify.display.mdAndUp">
			<!--通知icon-->
			<v-btn icon="mdi-bell-outline" variant="text"></v-btn>
			<!--下拉菜单-->
			<v-menu location="bottom">
				<template v-slot:activator="{ props }">
					<v-btn dark v-bind="props">
						欢迎, {{ username }}({{ email }})
					</v-btn>
				</template>
				<v-list :lines="false" density="comfortable" nav>
					<v-list-subheader>
						<div class="mx-auto pa-3 transition-swing text-subtitle-2 font-weight-black">
							我的账号
						</div>
					</v-list-subheader>
					<v-divider></v-divider>
					<v-list-item v-for="(item, i) in menuItems" :key="i" :value="item.title" color="primary"
						rounded="lg">
						<template v-slot:prepend>
							<v-icon :icon="item.icon" size="small"></v-icon>
						</template>
						<v-list-item-title v-text="item.title"></v-list-item-title>
					</v-list-item>
					<v-divider></v-divider>
					<v-list-item key="logout" value="logout" color="primary" rounded="lg" @click="handleLogout">
						<template v-slot:prepend>
							<v-icon icon="mdi-exit-to-app" size="small"></v-icon>
						</template>
						<v-list-item-title>退出登录</v-list-item-title>
					</v-list-item>
				</v-list>
			</v-menu>
		</template>
		<!--三竖点icon-->
		<!-- <v-btn icon="mdi-dots-vertical" variant="text"></v-btn> -->
	</v-app-bar>
	<!--侧边栏-->
	<v-navigation-drawer v-model="drawer" :location="$vuetify.display.mobile ? 'bottom' : undefined">
		<v-list-subheader>
			<div class="mx-auto pa-3 transition-swing text-subtitle-1 font-weight-black">
				菜单
			</div>
		</v-list-subheader>
		<v-divider></v-divider>
		<v-list :lines="false" density="comfortable" nav>
			<v-list-item v-for="(item, i) in displaySideItems" :key="i" :value="item.title" :to="item.routeLink"
				color="primary" rounded="lg">
				<template v-slot:prepend>
					<v-icon :icon="item.icon" size="small" :color="item.color"></v-icon>
				</template>
				<v-list-item-title v-text="item.title"></v-list-item-title>
			</v-list-item>
		</v-list>
	</v-navigation-drawer>
</template>

<script setup lang="ts">
import { useRouter, useRoute } from 'vue-router';
import { useAuthStore } from '@/stores/auth';

// 路由
const router = useRouter();
const route = useRoute();
// 用户状态
const authStore = useAuthStore();

// 定义响应式变量
// 可以直接使用ref、reactive等响应式 API，无需手动导入
const drawer = ref(true);
const group = ref(null);
const username = ref('');
const email = ref('');
const role = ref(1);
if (authStore.user) {
	// 取得用户的登录状态
	username.value = authStore.user.username || "";
	email.value = authStore.user.email || "";
	role.value = authStore.user.role!;
	// console.log(authStore.user.role, role.value);
}

const sideItems = [
	{
		title: '文件上传',
		routeLink: '/dashboard/upload',
		icon: 'mdi-tray-arrow-up',
		color: 'blue-darken-4',
	},
	{
		title: '上传历史',
		routeLink: '/dashboard/history',
		icon: 'mdi-history',
		color: 'teal-darken-2',
	},
	{
		title: '用户管理',
		routeLink: '/dashboard/users',
		icon: 'mdi-account-multiple-outline',
		color: 'purple-darken-3',
	},
	{
		title: '关于',
		routeLink: '/dashboard/about',
		icon: 'mdi-information-outline',
		color: 'orange-darken-4',
	},
];
const menuItems = [
	{
		title: '个人信息',
		routeLink: '',
		icon: 'mdi-account-outline',
	},
	{
		title: '设置',
		routeLink: '',
		icon: 'mdi-cog-outline',
	},
];

// 面包屑导航
const breadcrumbs = computed(() => {
	const pathArray = route.path.split('/').filter(i => i);
	return [
		// {
		// 	title: '首页',
		// 	disabled: false,
		// 	href: '/',
		// },
		...pathArray.map((path, index) => ({
			title: path.charAt(0).toUpperCase() + path.slice(1),
			disabled: index === pathArray.length - 1,
			href: '/' + pathArray.slice(0, index + 1).join('/'),
		}))
	];
});

// 使用 watchEffect
watchEffect(() => {
	if (group.value) {
		drawer.value = false;
	}
});

// 计算属性基于 role 的值动态地返回要显示的侧边栏菜单项数组
const displaySideItems = computed(() => {
	// 当 role 为 0 时（管理员），显示所有侧边栏
	// 当 role 不为 0 时（普通用户），显示除了用户管理以外的侧边栏
	return role.value === 0 ? sideItems : sideItems.filter(item => item.title !== '用户管理');
});

// 登出逻辑
const handleLogout = async () => {
	// 登出
	await authStore.logout();
	// 登出成功后跳转到 /login
	router.push('/login');
};
</script>

<style>
.v-breadcrumbs-item--disabled {
	opacity: 0.9 !important;
	color: #424242 !important;
	pointer-events: none !important;
}
</style>
