import { createRouter, createWebHistory } from 'vue-router';

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes: [
		{
			// 访问根路径重定向到/login
			path: '/',
			redirect: '/login'
		},
		{
			// 登录页面
			path: '/login',
			name: 'Login',
			component: () => import("@/views/Login.vue"),
		},
		{
			// 清单页面 - requireAuth用启用拦截
			path: '/todo',
			name: 'Todo',
			meta: {
				requireAuth: true
			},
			component: () => import("@/views/Todo.vue"),
		},
		{
			// 404页面
			path: '/:pathMatch(.*)*',
			name: '404',
			component: () => import('@/views/404.vue')
		}
	]
});

export default router;
