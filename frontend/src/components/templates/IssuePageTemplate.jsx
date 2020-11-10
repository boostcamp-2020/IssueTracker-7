import React, { useEffect, useState } from 'react';
import IssueList from '@organisms/IssueList';
import Header from '@organisms/Header';
import styled from 'styled-components';

const IssuePage = styled.div`
  width: auto;
`;
const IssuePageTemplate = () => {
  return (
    <IssuePage>
      <Header />
      <IssueList />
    </IssuePage>
  );
};
export default IssuePageTemplate;
