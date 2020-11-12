import React, { useEffect, useContext } from 'react';
import LoginPage from '@pages/LoginPage';
import IssuePage from '@pages/IssuePage';
import { BrowserRouter, Switch, Route, Redirect } from 'react-router-dom';
import { request } from '@utils/request';
import { IssueProvider } from '@stores/issue';
import { AuthProvider, AuthContext } from '@stores/auth';

const isAuthenticated = async () => await request('GET', '/api/auth/token');
const App = () => {
  const storedAccessToken = localStorage.getItem('accessToken');
  useEffect(async () => {
    if (location.pathname != '/login' && !storedAccessToken) {
      const { status, data } = await isAuthenticated();
      if (data.accessToken) {
        localStorage.setItem('accessToken', data.accessToken);
      } else {
        location.href = '/login';
      }
    }
  }, []);
  return (
    <AuthProvider>
      <IssueProvider>
        <BrowserRouter>
          <Switch>
            <Route path="/login" component={LoginPage} />
            <Route path="/issue" component={IssuePage} />
            <Redirect path="*" to="/issue" />
          </Switch>
        </BrowserRouter>
      </IssueProvider>
    </AuthProvider>
  );
};

export default App;
