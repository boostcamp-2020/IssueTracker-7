import React from 'react';
import GithubButton from '../components/login/GithubButton';

const LoginPage = () => {
    const handleGitHubLogin = () => {
        location.href = '/api/auth/github/web';
    };
    return (
        <GithubButton onClick={handleGitHubLogin}>Sign with GitHub</GithubButton>
    );
};

export default LoginPage;