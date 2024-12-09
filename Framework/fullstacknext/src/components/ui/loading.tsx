import React from 'react';
import { Loader2 } from 'lucide-react';

interface LoadingProps {
	isLoading: boolean;
}

export const Loading: React.FC<LoadingProps> = ({ isLoading }) => {
	if (!isLoading) return null;

	return (
		/*
		<div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
			<div className="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-primary"></div>
		</div>
		*/
		<div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
			<Loader2 className="h-16 w-16 animate-spin text-primary" />
		</div>
	);
};
