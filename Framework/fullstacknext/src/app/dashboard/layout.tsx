//import { Suspense } from 'react';
import { Header } from "@/components/Header";
import { Sidebar } from "@/components/Sidebar";
//import Loading from './loading';

export default function DashboardLayout({
	children,
}: {
	children: React.ReactNode;
}) {
	return (
		<div className="min-h-screen">
			{/*<Suspense fallback={<Loading />}>*/}
			<Header />
			<div className="flex h-screen pt-16">
				<Sidebar />
				<main className="flex-1 overflow-y-auto p-6">
					{children}
				</main>
			</div>
			{/*</Suspense>*/}
		</div>
	);
}
