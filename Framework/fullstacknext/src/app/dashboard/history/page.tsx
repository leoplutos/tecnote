import { UploadHistory } from "@/components/UploadHistory";

export default function HistoryPage() {
	return (
		<div className="h-full p-6">
			<div className="flex items-center justify-between mb-4">
				<h1 className="text-2xl font-bold">上传历史</h1>
			</div>
			<UploadHistory />
		</div>
	);
}
