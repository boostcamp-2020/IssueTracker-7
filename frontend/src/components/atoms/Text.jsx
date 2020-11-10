import React from 'react';
import styled from 'styled-components';

const Text = styled.span`
  color: ${({ color }) => (color ? color : 'black')};
  weight: 800;
`;

export default Text;
