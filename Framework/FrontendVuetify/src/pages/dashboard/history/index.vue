<template>
	<v-container class="mt-4 ml-4">
		<v-row class="mt-4 ml-4">
			<h2 className="mb-4">上传历史</h2>
		</v-row>
		<v-row class="mt-4 ml-4">
			<v-col cols="11">
				<!-- 标准数据表 </v-col>-->
				<v-data-table v-model:page="page" :headers="tHeaders" he :items="tBodys" :items-per-page="itemsPerPage"
					item-value="id" class="elevation-1 data-table-style">
				</v-data-table>
			</v-col>
			<v-col cols="1">
				<v-spacer />
			</v-col>
		</v-row>
	</v-container>
</template>

<script lang="ts" setup>
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
	{ title: '文件名', key: 'filenm' },
	{ title: '上传日期', key: 'uploaddt' },
	{ title: '上传者', key: 'uploader' },
	{ title: '大小', key: 'size' },
]);
// 表内容
const tBodys = ref<any>([]);
for (let index = 0; index < 100; index++) {
	tBodys.value.push({
		id: index + 1,
		filenm: index % 2 === 0 ? "document.pdf" : "image.jpg",
		uploaddt: index % 2 === 1 ? "2023-05-01" : "2023-05-02",
		uploader: index % 2 === 0 ? "管理员" : "普通用户",
		size: `${(Math.random() * (1.0 - 10.0) + 10.0).toFixed(2)} MB`,
	});
}

// 计算属性: 有几页
const pageCount = computed(() => {
	return Math.ceil(tBodys.value.length / itemsPerPage.value);
});

definePage({
	meta: {
		// 此页面[需要]登录后才可访问
		requiresAuth: true,
	},
});
</script>

<style>
.data-table-style {
	/* 表格整体样式 */
	border: 1px solid #e7eaf0;
	border-radius: 4px;
	overflow: hidden;
}

.data-table-style th {
	/* 表头样式 */
	background-color: #33373f !important;
	color: #d2d7e0 !important;
	font-weight: 600;
	font-size: 1.0rem;
}

.data-table-style td {
	/* 单元格样式 */
	color: #272c34;
}

.data-table-style tr:nth-child(even) {
	/* 偶数行背景色 */
	background-color: #fafafa;
}

.data-table-style tr:hover {
	/* 鼠标悬停效果 */
	background-color: #e3f2fd !important;
}

/* 分页控件样式 */
.data-table-style .v-data-table-footer {
	/*background-color: #fcfcff;*/
	/*border-top: 1px solid #e0e0e0;*/
	font-weight: 600;
}
</style>
