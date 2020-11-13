import React, { useEffect, useContext } from 'react';
import P from '@pages/';
import { BrowserRouter, Switch, Route, Redirect } from 'react-router-dom';
import { request } from '@utils/request';
import { IssueProvider } from '@stores/issue';
import { AuthProvider } from '@stores/auth';
import { FilterProvider } from '@stores/filter';
import { LabelProvider } from '@stores/label';
import { UserProvider } from '@stores/user';
import { MilestoneProvider } from '@stores/milestone';

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
        <FilterProvider>
          <LabelProvider>
            <UserProvider>
              <MilestoneProvider>
                <BrowserRouter>
                  <Switch>
                    <Route path="/login" component={P.LoginPage} />
                    <Route path="/issue" component={P.IssuePage} />
                    <Redirect path="*" to="/issue" />
                  </Switch>
                </BrowserRouter>
              </MilestoneProvider>
            </UserProvider>
          </LabelProvider>
        </FilterProvider>
      </IssueProvider>
    </AuthProvider>
  );
};

export default App;
