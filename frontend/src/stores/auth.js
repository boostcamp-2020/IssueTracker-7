import React, { useReducer, createContext } from 'react';

const authReducer = (authState, action) => {
  switch (action.type) {
    case 'LOGIN':
      return {
        accessToken: action.accessToken,
      };
    case 'LOGOUT':
      return {};
  }
};

const AuthContext = createContext({});
const AuthProvider = ({ children }) => {
  const storedAccessToken = localStorage.getItem('accessToken');
  const [authState, authDispatch] = useReducer(authReducer, { accessToken: storedAccessToken });
  return (
    <AuthContext.Provider value={{ authState, authDispatch }}>{children}</AuthContext.Provider>
  );
};

export { AuthProvider, AuthContext };
