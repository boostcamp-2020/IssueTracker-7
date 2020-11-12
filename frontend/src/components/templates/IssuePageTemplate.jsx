import React, { useEffect, useState } from 'react';
import styled from 'styled-components';
import A from '@atoms/';
import O from '@organisms/';

const IssuePage = styled.div`
  width: auto;
  background-color: #ffffff;
`;

const IssuePageTemplate = () => {
  return (
    <IssuePage>
    <O.Header />
      <A.Wrapper>
        <O.IssueList />
      </A.Wrapper>
    </IssuePage>
  );
};
export default IssuePageTemplate;
