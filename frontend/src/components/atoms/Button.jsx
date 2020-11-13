import React from 'react';
import styled from 'styled-components';

const Button = styled.button`
  width: 100%;
  height: 33px;
  font-weight: bold;
  color: ${(props) => props.color};
  background-color: ${(props) => props.backgroundColor};
  border-radius: 3px;
  border: none;
  outline: none;
  cursor: pointer;
`;

export default Button;
