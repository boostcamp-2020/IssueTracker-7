import React, { useReducer, useContext, createContext, useState, useEffect } from 'react';

const filterReducer = (state, { type, value }) => {
  switch (type) {
    case 'is':
      state.is = state.is.filter((option) => option != 'closed' && option != 'open');
      return {
        ...state,
        is: [...state.is, value],
      };
    default:
      if (value == '@me') {
        Object.keys(state).forEach((eachType) => {
          if (state[eachType] == '@me') delete state[eachType];
        });
      } else if (state[type] == value) {
        delete state[type];
        return {
          ...state,
        };
      }
      return {
        ...state,
        [type]: value,
      };
  }
};

const FilterContext = createContext();
const useFilter = () => useContext(FilterContext);
const makeFilterToQueryString = (filter) =>
  Object.keys(filter).reduce((q, option) => {
    let result = q;
    if (option == 'is') filter[option].forEach((isOption) => (result += `${option}:${isOption} `));
    else result += `${option}:"${filter[option]}"`;
    return result + ' ';
  }, '');
const FilterProvider = ({ children }) => {
  const [query, setQuery] = useState('is:issue is:open');
  const [filters, filterDispatch] = useReducer(filterReducer, { is: ['issue', 'open'] });
  useEffect(() => {
    setQuery(makeFilterToQueryString(filters));
  }, [filters]);
  return (
    <FilterContext.Provider value={{ filters, query, filterDispatch }}>
      {children}
    </FilterContext.Provider>
  );
};

export { FilterProvider, useFilter };
