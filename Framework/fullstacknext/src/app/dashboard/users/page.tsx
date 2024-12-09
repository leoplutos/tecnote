import { UserManagement } from "@/components/UserManagement";

export default function UsersPage() {
	return (
		<div className="h-full p-6">
			<div className="flex items-center justify-between mb-4">
				<h1 className="text-2xl font-bold">用户管理</h1>
			</div>
			<UserManagement />
		</div>
	);
}
