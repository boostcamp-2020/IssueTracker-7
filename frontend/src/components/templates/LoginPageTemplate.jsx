import React from 'react';
import styled from 'styled-components';
import O from '@organisms/';
import '@styles/LoginPage.css';

const LoginPageTemplate = () => {
  const LoginPage = styled.div`
    width: fit-content;
    padding-left: 40%;
    padding-top: 100px;
  `;

  const LoginTitle = styled.p`
    font-weight: bold;
    font-size: 25px;
    text-align: center;
  `;

  return (
    <LoginPage>
      <LoginTitle>이슈 트래커</LoginTitle>
      <O.LoginForm></O.LoginForm>
    </LoginPage>
  );
};

export default LoginPageTemplate;
