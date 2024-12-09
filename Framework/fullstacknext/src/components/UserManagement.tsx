'use client';

import { useState } from 'react';
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";

export function UserManagement() {
	const [users, setUsers] = useState([
		{ id: 1, name: '张三', email: 'zhangsan@example.com' },
		{ id: 2, name: '李四', email: 'lisi@example.com' },
	]);
	const [newUser, setNewUser] = useState({ name: '', email: '' });

	const addUser = (e: React.FormEvent) => {
		e.preventDefault();
		setUsers([...users, { id: users.length + 1, ...newUser }]);
		setNewUser({ name: '', email: '' });
	};

	return (
		<div className="space-y-4">
			<form onSubmit={addUser} className="flex space-x-2">
				<Input
					placeholder="姓名"
					value={newUser.name}
					onChange={(e) => setNewUser({ ...newUser, name: e.target.value })}
					required
				/>
				<Input
					placeholder="邮箱"
					type="email"
					value={newUser.email}
					onChange={(e) => setNewUser({ ...newUser, email: e.target.value })}
					required
				/>
				<Button type="submit">添加用户</Button>
			</form>
			<Table>
				<TableHeader>
					<TableRow>
						<TableHead>ID</TableHead>
						<TableHead>姓名</TableHead>
						<TableHead>邮箱</TableHead>
					</TableRow>
				</TableHeader>
				<TableBody>
					{users.map((user) => (
						<TableRow key={user.id}>
							<TableCell>{user.id}</TableCell>
							<TableCell>{user.name}</TableCell>
							<TableCell>{user.email}</TableCell>
						</TableRow>
					))}
				</TableBody>
			</Table>
		</div>
	);
}
