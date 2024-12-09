import { Loader2 } from 'lucide-react';

export default function Loading() {
	return (
		<div className="flex h-screen w-full items-center justify-center bg-gray-100">
			<div className="text-center">
				<Loader2 className="mx-auto h-16 w-16 animate-spin text-gray-600" />
				<h2 className="mt-4 text-2xl font-semibold text-gray-700">加载中...</h2>
				<p className="mt-2 text-gray-500">请稍候，我们正在准备您的内容</p>
			</div>
		</div>
	);
}
