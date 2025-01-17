// Utilities
import { createPinia } from 'pinia';
// 持久化 Pinia 状态的插件
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate';

const pinia = createPinia();
pinia.use(piniaPluginPersistedstate);

export default pinia;
