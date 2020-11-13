import React, { useReducer, createContext, useContext } from 'react';

const userReducer = (user, action) => {
  switch (action.type) {
    case 'GET':
      return action.data;
  }
};

const userContext = createContext();
const useUser = () => useContext(userContext);
const UserProvider = ({ children }) => {
  const [users, userDispatch] = useReducer(userReducer, []);
  return <userContext.Provider value={{ users, userDispatch }}>{children}</userContext.Provider>;
};
export { useUser, UserProvider };
