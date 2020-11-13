import React from 'react';
import styled, { createGlobalStyle } from 'styled-components';
import O from '@organisms/';

const LoginPageTemplate = () => {
  const GlobalStyle = createGlobalStyle`
    body {
      margin: 0;
      background-color: ${props => props.backgroundColor || '#ffffff'};
    }
  `;

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
    <>
      <GlobalStyle backgroundColor='#eeeeee'/>
        <LoginPage>
          <LoginTitle>이슈 트래커</LoginTitle>
          <O.LoginForm></O.LoginForm>
      </LoginPage>
      </>
  );
};

export default LoginPageTemplate;
