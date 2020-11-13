import React from 'react';
import styled from 'styled-components';

const Input = styled.input`
  width: ${(props) => props.width};
  height: ${(props) => props.height};
  border: 1px solid #d6d8db;
`;

export default Input;
