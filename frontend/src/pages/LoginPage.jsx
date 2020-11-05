import React from 'react';
import GithubButton from '../components/login/GithubButton';
import{ FontAwesomeIcon }from"@fortawesome/react-fontawesome";
import { faGithub } from '@fortawesome/free-brands-svg-icons';

const LoginPage = () => {
    const handleGitHubLogin = () => {
        location.href = '/api/auth/github/web';
    };
    return (
        <GithubButton onClick={handleGitHubLogin}>Sign with GitHub <FontAwesomeIcon icon={faGithub} /></GithubButton>
    );
};

export default LoginPage;