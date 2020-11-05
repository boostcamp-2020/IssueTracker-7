import React from 'react';
import GithubButton from '../components/login/GithubButton';
import '@fortawesome/fontawesome-free/js/all';

const LoginPage = () => {
    const handleGitHubLogin = () => {
        location.href = '/api/auth/github/web';
    };
    return (
        <GithubButton onClick={handleGitHubLogin}>Sign with GitHub <i className="fab fa-github" /></GithubButton>
    );
};

export default LoginPage;