import React, { useReducer, createContext, useContext } from 'react';

const issueReducer = (issues, action) => {
  switch (action.type) {
    case 'GET':
      return action.data || [];
  }
};

const IssueContext = createContext();
const useIssue = () => useContext(IssueContext);
const IssueProvider = ({ children }) => {
  const [issues, issueDispatch] = useReducer(issueReducer, []);
  return (
    <IssueContext.Provider value={{ issues, issueDispatch }}>{children}</IssueContext.Provider>
  );
};

export { IssueProvider, useIssue };
