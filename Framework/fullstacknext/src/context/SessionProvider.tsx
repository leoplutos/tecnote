'use client';

import React from 'react';
import { SessionProvider as AuthSessionProvider } from 'next-auth/react';

type Props = {};

// 此Provider未使用
const SessionProvider = ({ children }: { children: React.ReactNode; }) => {
	return (
		<AuthSessionProvider>{children}</AuthSessionProvider>
	);
};

export default SessionProvider;
