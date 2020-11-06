import React from "react";
import LoginPage from '@pages/LoginPage'
import IssuePage from '@pages/IssuePage'
import { BrowserRouter, Switch, Route, Redirect } from "react-router-dom";


const App = () => {
  return (
  <BrowserRouter>
    <Switch>
      <Route path="/login"><LoginPage/></Route>
      <Route path="/issue"><IssuePage/></Route>
      <Redirect path="*" to="/issue" />
    </Switch>
  </BrowserRouter>
  )
};

export default App;