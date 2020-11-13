import React, { useEffect, useState } from 'react';
import styled, { createGlobalStyle } from 'styled-components';
import A from '@atoms/';
import O from '@organisms/';
import M from '@molecules/'

const GlobalStyle = createGlobalStyle`
    body {
      margin: 0;
      background-color: ${props => props.backgroundColor || '#ffffff'};
    }
  `;
const IssuePage = styled.div`
  width: auto;
  background-color: #ffffff;
`;

const IssuePageTemplate = () => {
  return (
    <>
      <GlobalStyle />
      <IssuePage>
      <O.Header />
        <A.Wrapper>
          <O.SearchBar />
          <M.InitFilterButton />
          <O.IssueList />
        </A.Wrapper>
      </IssuePage>
    </>
  );
};
export default IssuePageTemplate;
