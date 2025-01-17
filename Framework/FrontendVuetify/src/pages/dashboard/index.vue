<template>
	<v-container class="mt-4 ml-4">
		<v-row class="mt-4 ml-4">
			<h2 className="mb-4">欢迎来到文件管理系统</h2>
		</v-row>
		<v-row class="mt-4 ml-4">
			<p>访问趋势</p>
		</v-row>
		<v-row class="mt-4 ml-4">
			<v-col cols="8">
				<v-card class="overflow-visible">
					<v-sparkline :auto-line-width="true" :fill="false" gradient-direction="top" width="200"
						line-width="1" height="75" label-size="4" :gradient="['#93bafa', '#00bcd4', '#1feaea']"
						:model-value="values" :padding="16" :smooth="true" :stroke-linecap="'round'" :type="'trend'"
						auto-draw>
						<template v-slot:label="item">
							{{ labels[values.indexOf(parseInt(item.value))] }} 月
						</template>
					</v-sparkline>
				</v-card>
			</v-col>
			<v-col cols="4">
				<v-spacer />
			</v-col>
		</v-row>
	</v-container>
</template>

<script lang="ts" setup>
const labels = [
	'3',
	'4',
	'5',
	'6',
	'7',
	'8',
	'9',
	'10',
];
const values = [
	200,
	675,
	410,
	390,
	310,
	460,
	250,
	840,
];

definePage({
	meta: {
		// 此页面[需要]登录后才可访问
		requiresAuth: true,
	},
});
</script>
