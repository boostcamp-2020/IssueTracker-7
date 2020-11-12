import React, { useReducer, createContext, useEffect } from 'react';

const issueReducer = (issues, action) => {
  return action;
};

const IssueContext = createContext();

const IssueProvider = ({ children }) => {
  const [issues, issueDispatch] = useReducer(issueReducer, []);
  return (
    <IssueContext.Provider value={{ issues, issueDispatch }}>{children}</IssueContext.Provider>
  );
};

export { IssueProvider, IssueContext };
