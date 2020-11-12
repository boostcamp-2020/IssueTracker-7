import React, { useEffect, useState } from 'react';
import styled from 'styled-components';
import A from '@atoms/';
import O from '@organisms/';

const IssuePage = styled.div`
  width: 100%;
  background-color: #ffffff;
`;

const IssuePageTemplate = () => {
  return (
    <IssuePage>
      <A.Wrapper>
        <O.Header />
        <O.IssueList />
      </A.Wrapper>
    </IssuePage>
  );
};
export default IssuePageTemplate;
