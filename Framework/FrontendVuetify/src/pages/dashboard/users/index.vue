<template>
	<v-container class="mt-4 ml-4">
		<v-row class="mt-4 ml-4">
			<h2 className="mb-4">用户管理</h2>
		</v-row>
		<v-row class="mt-4 ml-4">
			<!-- 添加用户按钮和子窗口 -->
			<v-dialog v-model="dialog" max-width="600">
				<template v-slot:activator="{ props: activatorProps }">
					<v-btn color="black" prepend-icon="mdi-account-edit" text="添加用户" v-bind="activatorProps"></v-btn>
				</template>
				<v-form @submit.prevent="handleAddUser" v-model="isValid">
					<v-card prepend-icon="mdi-account" title="用户信息">
						<v-card-text>
							<v-row dense>
								<v-col>
									<v-text-field v-model="addUsername" label="用户名*" :rules="[v => !!v || '请输入用户名']"
										required></v-text-field>
								</v-col>
							</v-row>
							<v-row dense>
								<v-col>
									<v-text-field v-model="addEmail" label="邮箱*" :rules="[v => !!v || '请输入邮箱']"
										required></v-text-field>
								</v-col>
							</v-row>
							<v-row dense>
								<v-col>
									<v-select v-model="addRole" :items="roleItems" label="权限*"
										:rules="[v => !!v || '请选择权限']" required></v-select>
								</v-col>
							</v-row>
							<small class="text-caption text-medium-emphasis">* 为必填项目</small>
						</v-card-text>
						<v-divider></v-divider>
						<v-card-actions>
							<v-spacer></v-spacer>
							<v-btn color="black" text="关闭" variant="tonal" @click="dialog = false"></v-btn>
							<v-btn color="black" text="保存" variant="tonal" type="submit" :loading="loading"
								:disabled="!isValid || loading"></v-btn>
						</v-card-actions>
					</v-card>
				</v-form>
			</v-dialog>
		</v-row>
		<v-row class="mt-4 ml-4">
			<v-col cols="11">
				<!-- 标准数据表 -->
				<v-data-table v-model:page="page" :headers="tHeaders" :items="tBodys" :items-per-page="itemsPerPage"
					item-value="id">
				</v-data-table>
			</v-col>
			<v-col cols="1">
				<v-spacer />
			</v-col>
		</v-row>
	</v-container>
	<!--定义按下保存按钮后的Loading Dialog-->
	<v-dialog v-model="loading" max-width="280" persistent>
		<v-list class="py-2" color="primary" elevation="12" rounded="lg">
			<v-list-item prepend-icon="$vuetify-outline" title="添加用户中...">
				<template v-slot:prepend>
					<div class="pe-4">
						<v-icon icon="mdi-account-box-plus-outline" color="blue-grey" size="x-large"></v-icon>
					</div>
				</template>
				<template v-slot:append>
					<v-progress-circular color="blue-grey" indeterminate="disable-shrink" size="28"
						width="3"></v-progress-circular>
				</template>
			</v-list-item>
		</v-list>
	</v-dialog>
	<!--消息条-->
	<v-snackbar v-model="snackbar" timeout="2000" color="blue-grey-darken-3" rounded="lg">
		<v-icon icon="mdi-check" start></v-icon>
		{{ addUserResult }}
		<template v-slot:actions>
			<v-btn color="lime-lighten-3" variant="text" @click="snackbar = false">关闭</v-btn>
		</template>
	</v-snackbar>
</template>

<script lang="ts" setup>
// 是否打开dialog子窗口
const dialog = ref(false);
// 这个例子使用的 标准数据表（v-data-table）
// 标准数据表假定整个数据集在本地可用
// 实际使用时会从后端取得数据, 建议使用 服务端数据表（v-data-table-server）
// https://vuetifyjs.com/zh-Hans/components/data-tables/server-side-tables/
// 页数
const page = ref(1);
// 每页显示行数
const itemsPerPage = ref(5);
// 表头
const tHeaders = ref<any>([
	{
		title: 'ID',
		key: 'id',
		align: 'start',
		sortable: false,
	},
	{ title: '用户名', key: 'username' },
	{ title: '邮箱', key: 'email' },
	{ title: '权限', key: 'role' },
]);
// 表内容
const tempUserIndex = ref(0); // 临时使用的变量, 实际项目不要使用
const tBodys = ref<any>([]);
for (let index = 0; index < 3; index++) {
	tBodys.value.push({
		id: index + 1,
		username: index % 2 === 0 ? "张三" : "李四",
		email: index % 2 === 0 ? "zhangsan@example.com" : "	lisi@example.com",
		role: index % 2 === 0 ? "管理员" : "普通用户",
	});
	tempUserIndex.value = index + 1;
}

const isValid = ref(false);
// 加载Loading
const loading = ref(false);
// 消息条
const snackbar = ref(false);
// 添加的用户
const addUsername = ref('');
const addEmail = ref('');
const addRole = ref('');
const roleItems = ref([
	{ value: '0', title: '管理员' },
	{ value: '1', title: '普通用户' },
]);
const addUserResult = ref('');

// 添加用户逻辑
const handleAddUser = async () => {
	// 打开Loading
	loading.value = true;
	// 这里应该调用实际的后端API
	// 模拟1秒操作
	await new Promise((resolve) => {
		setTimeout(resolve, 1000);
	});

	// 从选择的 RoleId 取得实际的内容 (管理员 or 普通用户)
	const selectedRole = roleItems.value.find(item => item.value === addRole.value);
	tBodys.value.push({
		id: ++tempUserIndex.value,
		username: addUsername.value,
		email: addEmail.value,
		role: selectedRole?.title || '',
	});
	addUserResult.value = `添加用户 ${addUsername.value} 成功`;
	addUsername.value = '';
	addEmail.value = '';
	addRole.value = '';
	// 关闭子窗口
	dialog.value = false;
	// 关闭Loading
	loading.value = false;
	// 打开消息条
	snackbar.value = true;
};

definePage({
	meta: {
		// 此页面[需要]登录后才可访问
		requiresAuth: true,
	},
});
</script>
