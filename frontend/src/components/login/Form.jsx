import React from 'react';
import styled from 'styled-components';
import InputBox from '@components/login/InputBox';
import FlexBox from '@components/common/FlexBox';
import TextButton from '@components/common/TextButton';
import GithubButton from '@components/login/GithubButton';
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faGithub } from '@fortawesome/free-brands-svg-icons';

const Form = styled.form`
    margin-top: 50px;
    width: fit-content;
    padding: 25px;
    background-color: #ffffff;
    border: 1px solid #8f8f8f;
    border-radius: 3px;
`;

const handleClick = (e) => {
    e.preventDefault()
    alert('GitHub 로그인을 이용하세요.')
}

const handleGitHubLogin = (e) => {
    e.preventDefault()
    location.href = '/api/auth/github/web';
};

const LoginForm = () => {
    return (
        <Form>
            <InputBox label='아이디' type='text'></InputBox>
            <InputBox label='비밀번호' type='password'></InputBox>
            <FlexBox direction="row">
                <TextButton type="submit" value="로그인" onClick={handleClick}/>
                <TextButton type="button" value="회원가입" onClick={handleClick}/>
            </FlexBox>
            <GithubButton onClick={handleGitHubLogin}>
                Sign with GitHub <FontAwesomeIcon icon={faGithub} />
            </GithubButton>
        </Form>
    );
};

export default LoginForm;