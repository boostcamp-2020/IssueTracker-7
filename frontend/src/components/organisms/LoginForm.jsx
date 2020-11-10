import React from 'react';
import styled from 'styled-components';
import InputBox from '@molecules/InputBox';
import FlexBox from '@atoms/FlexBox';
import TextButton from '@atoms/TextButton';
import GithubButton from '@molecules/GithubButton';

const Form = styled.form`
  margin-top: 50px;
  width: fit-content;
  padding: 25px;
  background-color: #ffffff;
  border: 1px solid #8f8f8f;
  border-radius: 3px;
  ${TextButton} {
    flex: 1;
  }
`;

const handleClick = (e) => {
  e.preventDefault();
  alert('GitHub 로그인을 이용하세요.');
};

const handleGitHubLogin = (e) => {
  e.preventDefault();
  location.href = '/api/auth/github/web';
};

const LoginForm = () => {
  return (
    <Form>
      <InputBox label="아이디" type="text"></InputBox>
      <InputBox label="비밀번호" type="password"></InputBox>
      <FlexBox direction="row">
        <TextButton type="submit" value="로그인" onClick={handleClick} />
        <TextButton type="button" value="회원가입" onClick={handleClick} />
      </FlexBox>
      <GithubButton onClick={handleGitHubLogin} />
    </Form>
  );
};

export default LoginForm;
