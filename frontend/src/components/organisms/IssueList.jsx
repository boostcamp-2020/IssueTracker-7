import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import IssueItem from '@organisms/IssueItem';
import { request } from '@utils/request';

const IssueListContainer = styled.ul`
  min-width: 1200px;
  width: 1200px;
  padding: 0 32px;
  margin: 0 auto;
  list-style-type: none;
`;

const IssueList = (props) => {
  const [issues, setIssues] = useState([]);
  useEffect(async () => {
    const { status, data } = await request('GET', '/api/issue');
    setIssues(data);
  }, []);
  const issueList = issues.map((issue) => <IssueItem key={issue.id} {...issue} />);
  return <IssueListContainer>{issueList}</IssueListContainer>;
};
export default IssueList;
