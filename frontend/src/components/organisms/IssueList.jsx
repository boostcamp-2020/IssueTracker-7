import React, { useContext, useState, useEffect } from 'react';
import styled from 'styled-components';
import { IssueContext } from '@stores/issue';
import O from '@organisms/';

const IssueListContainer = styled.ul`
  min-width: 1200px;
  width: 1200px;
  padding: 0 32px;
  margin: 0 auto;
  list-style-type: none;
`;

const IssueList = () => {
  const { issues, issueDispatch } = useContext(IssueContext);
  const issueList = issues.map((issue) => <O.IssueItem key={issue.id} {...issue} />);
  return <IssueListContainer>{issueList}</IssueListContainer>;
};
export default IssueList;
