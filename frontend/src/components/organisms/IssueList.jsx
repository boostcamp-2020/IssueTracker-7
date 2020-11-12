import React, { useContext, useState, useEffect } from 'react';
import styled from 'styled-components';
import { IssueContext } from '@stores/issue';
import O from '@organisms/';

const IssueListContainer = styled.ul`
  width: 90%;
  padding: 0;
  margin: 0 auto;
  list-style-type: none;
`;

const IssueList = () => {
  const { issues, issueDispatch } = useContext(IssueContext);
  const issueList = issues.map((issue) => <O.IssueItem key={issue.id} {...issue} />);
  return (
    <>
      <O.Filter />
      <IssueListContainer>{issueList}</IssueListContainer>
    </>
  );
};
export default IssueList;
