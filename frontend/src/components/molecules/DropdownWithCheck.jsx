import React, { useState } from 'react';
import styled from 'styled-components';
import A from '@atoms/';
import { useFilter } from '@stores/filter';

const List = styled.div`
  display: flex;
  height: 35px;
  margin: 0;
  background-color: ${(props) => props.backgroundColor};
  border: none;
  &:hover {
    background-color: #eaecef;
    cursor: pointer;
  }
`;

const DropdownWithCheck = ({ type, value, onClick, children }) => {
  const { filters } = useFilter();
  return (
    <>
      {filters[type] == value && type != 'is' && value != '@me' ? (
        <List onClick={(event) => onClick(type, value)()} backgroundColor="#EAECEF">
          <A.Check />
          {children}
        </List>
      ) : (
        <List onClick={(event) => onClick(type, value)()}>
          <A.Uncheck />
          {children}
        </List>
      )}
    </>
  );
};

export default DropdownWithCheck;
