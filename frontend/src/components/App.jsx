import React from 'react';
import LoginPage from '@pages/LoginPage';
import IssuePage from '@pages/IssuePage';
import { BrowserRouter, Switch, Route, Redirect } from 'react-router-dom';

const App = () => {
  return (
    <BrowserRouter>
      <Switch>
        <Route path="/login" component={LoginPage} />
        <Route path="/issue" component={IssuePage} />
        <Redirect path="*" to="/issue" />
      </Switch>
    </BrowserRouter>
  );
};

export default App;
