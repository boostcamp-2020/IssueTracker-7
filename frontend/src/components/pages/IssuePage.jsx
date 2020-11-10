import React, { useEffect, useState } from 'react';
import { request } from '@utils/request';
import IssuePageTemplate from '@templates/IssuePageTemplate';
const isAuthenticated = async () => await request('GET', '/api/auth/token');

const IssuePage = () => {
  useEffect(async () => {
    const { status, data } = await isAuthenticated();
    if (!data.accessToken) {
      location.href = '/login';
    }
  }, []);
  return <IssuePageTemplate />;
};
export default IssuePage;
