import { createStore } from 'vuex';

//vuex-创建一个全局状态
//页面刷新会导致Vue实例重新初始化，而且Vuex中的状态也会重置。使用sessionStorage避免此问题
const store = createStore({
	state() {
		return {
			token: window.sessionStorage.getItem("token")
		};
	},
	mutations: {
		setToken(state, token: string) {
			state.token = token;
			window.sessionStorage.setItem("token", token);
		},
		removeToken(state) {
			state.token = '';
			window.sessionStorage.setItem("token", '');
		}
	}
});

export default store;
