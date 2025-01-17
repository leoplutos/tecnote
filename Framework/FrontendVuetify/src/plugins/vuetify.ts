/**
 * plugins/vuetify.ts
 *
 * Framework documentation: https://vuetifyjs.com`
 */

// Styles
import '@mdi/font/css/materialdesignicons.css';
import 'vuetify/styles';

// Composables
import { createVuetify } from 'vuetify';

// https://vuetifyjs.com/en/introduction/why-vuetify/#feature-guides
export default createVuetify({
	// 不使用服务器端渲染
	ssr: false,
	// 主题
	theme: {
		//defaultTheme: 'dark',
		defaultTheme: 'light',
	},
});
