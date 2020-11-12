import React, { useEffect, useContext } from 'react';
import { request } from '@utils/request';
import T from '@templates/';
import { IssueContext } from '@stores/issue';

const IssuePage = () => {
  const { issues, issueDispatch } = useContext(IssueContext);
  useEffect(async () => {
    const { status, data } = await request('GET', '/api/issue');
    issueDispatch(data);
  }, []);
  return <T.IssuePageTemplate issues={issues} />;
};
export default IssuePage;
