/**
 * router/index.ts
 *
 * Automatic routes for `./src/pages/*.vue`
 */

// Composables
import { createRouter, createWebHistory } from 'vue-router/auto';
import { setupLayouts } from 'virtual:generated-layouts';
import { routes } from 'vue-router/auto-routes';
import { useAuthStore } from "@/stores/auth";

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes: setupLayouts(routes),
});

// Workaround for https://github.com/vitejs/vite/issues/11804
router.onError((err, to) => {
	if (err?.message?.includes?.('Failed to fetch dynamically imported module')) {
		if (!localStorage.getItem('vuetify:dynamic-reload')) {
			console.log('Reloading page to fix dynamic import error');
			localStorage.setItem('vuetify:dynamic-reload', 'true');
			location.assign(to.fullPath);
		} else {
			console.error('Dynamic import error, reloading page did not fix it', err);
		}
	} else {
		console.error(err);
	}
});

router.isReady().then(() => {
	localStorage.removeItem('vuetify:dynamic-reload');
});

// 为每个路由添加权限判断以保护页面
router.beforeEach((to) => {
	// 用户状态
	const authStore = useAuthStore();
	// console.log(to.fullPath, to.meta.requiresAuth, authStore.isLoggedIn);
	if (to.meta.requiresAuth && !authStore.isLoggedIn) {
		// 需要登录保护 并且用户没有登录, 跳转到 /login
		return {
			path: "/login",
			//query: { redirect: to.fullPath },
		};
	} else {
	}
});

export default router;
