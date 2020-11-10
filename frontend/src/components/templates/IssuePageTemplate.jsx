import React, { useEffect, useState } from 'react';
import IssueList from '@organisms/IssueList';
import Header from '@organisms/Header';
import styled from 'styled-components';

const Center = styled.div`
  width: auto;
`;
const IssuePageTemplate = () => {
  return (
    <Center>
      <Header />
      <IssueList />
    </Center>
  );
};
export default IssuePageTemplate;
