import React from 'react';
import styled from 'styled-components';

const ColorSpace = styled.div`
  background-color: ${({ backgroundColor }) => (backgroundColor ? backgroundColor : 'white')};
  display: flex;
  justify-content: center;
  align-items: center;
  height: ${({ height }) => (height ? height : '80px')};
`;
export default ColorSpace;
