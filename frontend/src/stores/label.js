import React, { useReducer, createContext, useContext } from 'react';

const labelReducer = (labels, action) => {
  switch (action.type) {
    case 'GET':
      return action.data;
  }
};

const LabelContext = createContext();
const useLabel = () => useContext(LabelContext);
const LabelProvider = ({ children }) => {
  const [labels, labelDispatch] = useReducer(labelReducer, []);
  return (
    <LabelContext.Provider value={{ labels, labelDispatch }}>{children}</LabelContext.Provider>
  );
};
export { LabelProvider, useLabel };
