export default function AboutPage() {
	return (
		<div className="h-full p-6">
			<div className="flex items-center justify-between mb-4">
				<h1 className="text-2xl font-bold">关于</h1>
			</div>
			<div className="max-w-2xl">
				<p>
					这是一个文件管理系统，提供文件上传、历史记录查看等功能。系统使用 Next.js 和 React 构建，
					提供现代化的用户界面和流畅的使用体验。
				</p>
			</div>
		</div>
	);
}
