<template>
	<v-container class="fill-height">
		<v-row justify="center" align="center">
			<v-col cols="12" sm="8" md="6" lg="4">
				<v-card class="pa-8" elevation="8">
					<div class="text-center text-h4 mb-8">文件管理系统</div>
					<v-form @submit.prevent="handleLogin" v-model="isValid">
						<v-text-field v-model="userid" label="用户名" :rules="[v => !!v || '请输入用户名']" required
							variant="outlined" class="mb-4" :disabled="loading"></v-text-field>
						<v-text-field v-model="password" label="密码" type="password" :rules="[v => !!v || '请输入密码']"
							required variant="outlined" class="mb-4" :disabled="loading"></v-text-field>
						<v-btn block color="black" size="large" type="submit" :loading="loading"
							:disabled="!isValid || loading" class="mt-4">
							登录
						</v-btn>
					</v-form>
					<v-alert v-if="errorMessage" type="error" class="mt-4" closable @click:close="errorMessage = ''">
						{{ errorMessage }}
					</v-alert>
				</v-card>
			</v-col>
		</v-row>
		<!--定义按下登录按钮后的Loading Dialog-->
		<v-dialog v-model="loading" max-width="280" persistent>
			<v-list class="py-2" color="primary" elevation="12" rounded="lg">
				<v-list-item prepend-icon="$vuetify-outline" title="登录中...">
					<template v-slot:prepend>
						<div class="pe-4">
							<v-icon icon="mdi-music" color="blue-grey" size="x-large"></v-icon>
						</div>
					</template>
					<template v-slot:append>
						<v-progress-circular color="blue-grey" indeterminate="disable-shrink" size="28"
							width="3"></v-progress-circular>
					</template>
				</v-list-item>
			</v-list>
		</v-dialog>
	</v-container>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
import { useAuthStore } from '@/stores/auth';

// 路由
const router = useRouter();
// 用户状态
const authStore = useAuthStore();

const userid = ref('');
const password = ref('');
const loading = ref(false);
const isValid = ref(false);
const errorMessage = ref('');

// 登录逻辑
const handleLogin = async () => {
	loading.value = true;
	errorMessage.value = '';
	// 模拟1秒操作
	await new Promise((resolve) => {
		setTimeout(resolve, 1000);
	});
	try {
		// 登录
		await authStore.login({
			userid: userid.value,
			password: password.value
		});
		// 登录成功后跳转到 /dashboard
		router.push('/dashboard');
	} catch (error) {
		errorMessage.value = error instanceof Error ? error.message : '登录失败，请稍后重试';
	} finally {
		loading.value = false;
	}
};
</script>
