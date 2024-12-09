'use client';

import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";

export function UploadHistory() {
	const uploadHistory = [
		{ id: 1, filename: 'document.pdf', uploadDate: '2023-05-01', size: '2.5 MB' },
		{ id: 2, filename: 'image.jpg', uploadDate: '2023-05-02', size: '1.8 MB' },
		{ id: 3, filename: 'spreadsheet.xlsx', uploadDate: '2023-05-03', size: '3.2 MB' },
	];

	return (
		<div>
			<Table>
				<TableHeader>
					<TableRow>
						<TableHead>ID</TableHead>
						<TableHead>文件名</TableHead>
						<TableHead>上传日期</TableHead>
						<TableHead>大小</TableHead>
					</TableRow>
				</TableHeader>
				<TableBody>
					{uploadHistory.map((item) => (
						<TableRow key={item.id}>
							<TableCell>{item.id}</TableCell>
							<TableCell>{item.filename}</TableCell>
							<TableCell>{item.uploadDate}</TableCell>
							<TableCell>{item.size}</TableCell>
						</TableRow>
					))}
				</TableBody>
			</Table>
		</div>
	);
}
