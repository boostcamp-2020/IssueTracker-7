import React from 'react';
import styled from 'styled-components';
import M from '@molecules/';
import A from '@atoms/';
const Form = styled.form`
  margin-top: 50px;
  width: fit-content;
  padding: 25px;
  background-color: #ffffff;
  border: 1px solid #8f8f8f;
  border-radius: 3px;
  ${A.TextButton} {
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
      <M.InputBox label="아이디" type="text"></M.InputBox>
      <M.InputBox label="비밀번호" type="password"></M.InputBox>
      <A.FlexBox direction="row">
        <A.TextButton type="submit" value="로그인" onClick={handleClick} />
        <A.TextButton type="button" value="회원가입" onClick={handleClick} />
      </A.FlexBox>
      <M.GithubButton onClick={handleGitHubLogin} />
    </Form>
  );
};

export default LoginForm;
