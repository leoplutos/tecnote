<template>
	<v-container class="mt-4 ml-4">
		<v-row class="mt-4 ml-4">
			<h2 className="mb-4">文件上传</h2>
		</v-row>
		<v-row class="mt-4 ml-4">
			<v-col cols="8">
				<!--使用v-file-input实现的文件上传-->
				<!--
				<v-file-input v-model="files" :show-size="1000" color="deep-purple-accent-4" label="请点此上传文件"
					max-width="1000" placeholder="Select your files" prepend-icon="mdi-paperclip" variant="outlined"
					counter multiple>
					<template v-slot:selection="{ fileNames }">
						<template v-for="(fileName, index) in fileNames" :key="fileName">
							<v-chip v-if="index < 3" class="me-2" color="deep-purple-accent-4" size="small" label>
								{{ fileName }}
							</v-chip>
							<span v-else-if="index === 3" class="text-overline text-grey-darken-3 mx-2">
								+{{ files.length - 3 }} File(s)
							</span>
						</template>
</template>
</v-file-input>
-->
				<!--使用v-file-upload实现的文件上传, 需要版本 v3.7.6 以上 -->
				<v-file-upload v-model="files" browse-text="点击上传文件" divider-text="或者" icon="mdi-upload" title="将文件拖拽至此处"
					scrim="primary" clearable multiple show-size>
				</v-file-upload>
			</v-col>
			<v-col cols="4">
				<v-spacer />
			</v-col>
		</v-row>
	</v-container>
</template>

<script lang="ts" setup>
import { VFileUpload } from 'vuetify/labs/VFileUpload';

const files = ref([]);

definePage({
	meta: {
		// 此页面[需要]登录后才可访问
		requiresAuth: true,
	},
});
</script>
