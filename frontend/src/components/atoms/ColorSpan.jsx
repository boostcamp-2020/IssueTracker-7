import React from 'react';
import styled from 'styled-components';

const ColorSpan = styled.div`
  background-color: ${((props) => props.color) || '#ffffff'};
  color: ${(props) => (props.color > '#fff000' ? 'black' : 'white')};
  padding: 0 4px;
  font-weight: 800;
  margin: 0 4px;
`;

export default ColorSpan;
