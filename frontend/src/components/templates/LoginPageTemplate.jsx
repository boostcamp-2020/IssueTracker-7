import React, { useEffect, useState } from 'react';
import styled from 'styled-components';
import A from '@atoms/';
import O from '@organisms/';

const IssuePage = styled.div`
  width: 100%;
  background-color: #ffffff;
  margin: 0;
`;

const IssuePageTemplate = () => {
  return (
    <IssuePage>
      <A.Wrapper>
        <O.Header />
        <O.Filter />
        <O.IssueList />
      </A.Wrapper>
    </IssuePage>
  );
};
export default IssuePageTemplate;