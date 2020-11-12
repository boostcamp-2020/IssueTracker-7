import React from 'react';
import styled from 'styled-components';

const ColorSpan = styled.div`
  background-color: ${((props) => props.color) || '#ffffff'};
  color: ${(props) => (props.color > '#fff000' ? 'black' : 'white')};
  padding: 0 13px 3px 13px;
  font-weight: 13px;
  margin: 0 4px;
  border-radius: 15px;
`;

export default ColorSpan;
