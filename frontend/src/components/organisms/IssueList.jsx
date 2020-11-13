import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import { request } from '@utils/request';
import { useIssue } from '@stores/issue';
import { useFilter } from '@stores/filter';
import O from '@organisms/';

const IssueListContainer = styled.ul`
  padding: 0;
  margin: 0 auto;
  list-style-type: none;
`;

const IssueList = () => {
  const { issues, issueDispatch } = useIssue();
  const { query } = useFilter();
  const issueList = issues.map((issue) => <O.IssueItem key={issue.id} {...issue} />);
  useEffect(async () => {
    const { status, data } = await request('GET', `/api/issue/?q=${query}`);
    issueDispatch({
      type: 'GET',
      data,
    });
  }, [query]);
  return (
    <IssueListContainer>
      <O.Filter />
      {issueList}
    </IssueListContainer>
  );
};
export default IssueList;
