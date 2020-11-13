import React, { useReducer, createContext, useContext } from 'react';

const milestoneReducer = (milestones, action) => {
  switch (action.type) {
    case 'GET':
      return action.data;
  }
};

const MilestoneContext = createContext();

const MilestoneProvider = ({ children }) => {
  const [milestones, milestoneDispatch] = useReducer(milestoneReducer, []);
  return (
    <MilestoneContext.Provider value={{ milestones, milestoneDispatch }}>
      {children}
    </MilestoneContext.Provider>
  );
};
const useMilestone = () => useContext(MilestoneContext);
export { MilestoneProvider, useMilestone };
