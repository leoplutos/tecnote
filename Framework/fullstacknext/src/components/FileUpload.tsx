'use client';

import { useEffect, useState, useRef, useMemo, useCallback } from 'react';
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { UploadCloud } from 'lucide-react';
import { cn } from "@/lib/utils";

// 可最大上传文件数
const MAX_FILES = 10;
// 可最大上传单文件Size
const MAX_FILE_SIZE = 50 * 1024 * 1024; // 50MB
// 可最大上传总Size
const MAX_TOTAL_SIZE = 500 * 1024 * 1024; // 500MB

export function FileUpload() {
	// 上传的文件
	const [files, setFiles] = useState<File[]>([]);
	// 使用 useRef 创建一个对 files 状态的可变引用（解决状态更新的异步性）
	const filesRef = useRef<File[]>(files);
	// 是否在拖拽中
	const [isDragging, setIsDragging] = useState(false);
	// 错误定义
	const [error, setError] = useState<string | null>(null);

	// 计算当前文件总大小
	const totalSize = files.reduce((acc, file) => acc + file.size, 0);
	// 计算还能上传几个文件 使用 useMemo 钩子来缓存计算结果
	const remainingFiles = useMemo(() => {
		// files 状态发生变化时，useMemo 会重新执行回调函数计算新的 remainingFiles 值
		return MAX_FILES - files.length;
	}, [files]);
	// 计算上传剩余尺寸
	const remainingSize = MAX_TOTAL_SIZE - totalSize;

	// 监控 files 状态
	useEffect(() => {
		// 最新的 files 值赋值给 filesRef.current，使得 filesRef 始终指向最新的 files 数组内容
		filesRef.current = files;
	}, [files]);

	// 验证文件
	const validateFiles = (newFiles: File[]): boolean => {
		setError(null);

		const currentFiles = filesRef.current;
		// 检查文件总数限制
		if (currentFiles.length + newFiles.length > MAX_FILES) {
			setError(`最多只能上传 ${MAX_FILES} 个文件`);
			return false;
		}

		// 检查单个文件大小
		const oversizedFiles = newFiles.filter(file => file.size > MAX_FILE_SIZE);
		if (oversizedFiles.length > 0) {
			setError(`文件大小不能超过 50MB: ${oversizedFiles.map(f => f.name).join(', ')}`);
			return false;
		}

		// 检查重复文件
		const duplicateFiles = newFiles.filter(newFile =>
			currentFiles.some(existingFile => existingFile.name === newFile.name && existingFile.size === newFile.size)
		);
		if (duplicateFiles.length > 0) {
			setError(`以下文件已存在，将不会重复添加: ${duplicateFiles.map(f => f.name).join(', ')}`);
			return false;
		}

		// 检查总文件大小
		const newTotalSize = totalSize + newFiles.reduce((acc, file) => acc + file.size, 0);
		if (newTotalSize > MAX_TOTAL_SIZE) {
			setError('总文件大小不能超过 500MB');
			return false;
		}

		return true;
	};

	// 处理文件添加
	const handleFiles = (newFiles: File[]) => {
		/*
		const uniqueNewFiles = newFiles.filter(newFile =>
			!files.some(existingFile => existingFile.name === newFile.name && existingFile.size === newFile.size)
		);
		if (validateFiles(uniqueNewFiles)) {
			setFiles(prev => [...prev, ...uniqueNewFiles]);
		}
		*/
		if (validateFiles(newFiles)) {
			setFiles(prev => [...prev, ...newFiles]);
		}
	};

	// 处理文件输入改变
	const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
		if (e.target.files) {
			handleFiles(Array.from(e.target.files));
		}
	};

	// 处理拖拽事件
	const handleDrag = useCallback((e: React.DragEvent) => {
		// 阻止浏览器默认行为
		e.preventDefault();
		// 阻止事件冒泡
		e.stopPropagation();

		if (e.type === 'dragenter' || e.type === 'dragover') {
			setIsDragging(true);
		} else if (e.type === 'dragleave' || e.type === 'drop') {
			setIsDragging(false);
		}
	}, []);

	// 处理文件放下
	const handleDrop = useCallback((e: React.DragEvent) => {
		// 阻止浏览器默认行为
		e.preventDefault();
		// 阻止事件冒泡
		e.stopPropagation();

		setIsDragging(false);

		const droppedFiles = Array.from(e.dataTransfer.files);
		handleFiles(droppedFiles);
	}, []);

	// 处理文件上传
	const handleUpload = () => {
		// 这里实现实际的文件上传逻辑
		console.log('Uploading files:', files);
		// 上传完成后重置
		setFiles([]);
	};

	// 删除单个文件
	const handleRemoveFile = (index: number) => {
		setFiles(prev => prev.filter((_, i) => i !== index));
	};

	return (
		<div className="space-y-4">
			<div className="bg-gray-100 p-4 rounded-md mb-4 text-sm text-gray-700">
				<p>当前已传 {files.length} 个文件，共计 {(totalSize / 1024 / 1024).toFixed(2)} MB</p>
				<p>还能上传 {remainingFiles} 个文件，剩余空间 {(remainingSize / 1024 / 1024).toFixed(2)} MB</p>
			</div>
			<div
				className={cn(
					"border-2 border-dashed rounded-lg p-6 transition-colors",
					isDragging ? "border-primary bg-primary/10" : "border-gray-400",
					"cursor-pointer"
				)}
				onDragEnter={handleDrag}
				onDragOver={handleDrag}
				onDragLeave={handleDrag}
				onDrop={handleDrop}
				onClick={() => document.getElementById('file-input')?.click()}
			>
				<div className="flex flex-col items-center justify-center space-y-2 text-center">
					<UploadCloud className="h-8 w-8 text-gray-600" />
					<div className="text-sm">
						<span className="font-medium">点击上传</span>
						<span className="text-gray-600"> 或将文件拖至此处</span>
					</div>
					<p className="text-xs text-gray-600">
						最多上传10个文件，单文件50MB内，总大小500MB内
					</p>
					<Input
						id="file-input"
						type="file"
						onChange={handleFileChange}
						multiple
						className="hidden"
					/>
				</div>
			</div>

			{error && (
				<div className="text-sm text-red-500 mt-2">
					{error}
				</div>
			)}

			{files.length > 0 && (
				<div className="bg-gray-50 p-4 rounded-md">
					<div className="flex justify-between items-center mb-2">
						<h3 className="text-sm font-medium">
							已选择 {files.length} 个文件 (总计 {(totalSize / 1024 / 1024).toFixed(2)} MB)
						</h3>
						<Button
							onClick={handleUpload}
							size="sm"
						>
							<UploadCloud className="mr-2 h-4 w-4" />
							上传文件
						</Button>
					</div>
					<ul className="divide-y divide-gray-300">
						{files.map((file, index) => (
							<li key={index} className="py-2 flex justify-between items-center">
								<div className="flex-1">
									<p className="text-sm">{file.name}</p>
									<p className="text-xs text-gray-600">
										{(file.size / 1024 / 1024).toFixed(2)} MB
									</p>
								</div>
								<Button
									variant="ghost"
									size="sm"
									onClick={(e) => {
										e.stopPropagation();
										handleRemoveFile(index);
									}}
								>
									删除
								</Button>
							</li>
						))}
					</ul>
				</div>
			)}
		</div>
	);
}

