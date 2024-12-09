import { FileUpload } from "@/components/FileUpload";

export default function UploadPage() {
	return (
		<div className="h-full p-6">
			<div className="flex items-center justify-between mb-4">
				<h1 className="text-2xl font-bold">文件上传</h1>
			</div>
			<FileUpload />
		</div>
	);
}
