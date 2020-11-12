import React from 'react';
import styled from 'styled-components';
import CloseButton from '../../atoms/filter/CloseButton';
import FilterTitle from '../../atoms/filter/FilterTitle';

const Header = styled.div`
    display: flex;
    margin: 0;
`;

const FilterHeader = ({ onClick, children }) => {
    return (
        <Header>
            <FilterTitle>{children}</FilterTitle>
            <CloseButton onClick={onClick} />
        </Header>
    );
};

export default FilterHeader;