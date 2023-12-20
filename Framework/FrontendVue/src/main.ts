import { createApp } from 'vue';
import App from './App.vue';
import ElementPlus from 'element-plus';
import 'element-plus/dist/index.css';
import router from './router';
import store from './store';
import { type RouteLocationNormalized, type NavigationGuardNext } from 'vue-router';
import axios from '@/plugins/axiosInstance.js';


//vue-router钩子函数，访问路由前调用，注册全局前置守卫
router.beforeEach((to: RouteLocationNormalized, from: RouteLocationNormalized, next: NavigationGuardNext) => {
	// to:即将要进入的目标
	// from: 当前导航正要离开的路由
	//路由需要认证
	if (to.meta.requireAuth) {
		//判断store里是否有token
		if (store.state.token) {
			next();
		} else {
			next({
				path: 'login',
				query: { redirect: to.fullPath }
			});
		}
	} else {
		next();
	}
});

const app = createApp(App);
// 使用vue-router
app.use(router);
// 使用element-plus
app.use(ElementPlus);
// 使用vuex管理全局属性
app.use(store);
// 全局绑定http请求客户端-使用axios
//app.config.globalProperties.$axios = axios;
app.config.globalProperties.$http = axios;
app.mount('#app');
