import LoginForm from '@/components/LoginForm';

export default function Login() {
	return (
		<div className="flex items-center justify-center min-h-screen bg-gray-100">
			<div className="w-full max-w-md">
				<h1 className="text-2xl font-bold text-center mb-6">文件管理系统</h1>
				<LoginForm />
			</div>
		</div>
	);
}
