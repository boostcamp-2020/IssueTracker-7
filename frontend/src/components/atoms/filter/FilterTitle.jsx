import React from 'react';
import styled from 'styled-components';

const Title = styled.span`
    width: 230px;
    height: 30px;
    font-size: 14px;
    font-weight: bold;
    padding: 8px 0 0 20px;
`;

const FilterTitle = ({children}) => {
  return <Title>{children}</Title>
};

export default FilterTitle;