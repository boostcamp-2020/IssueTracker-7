import React from 'react';
import styled from 'styled-components';
import FilterOverlay from '../../atoms/filter/FilterOverlay';
import FilterHeader from './FilterHeader';
import FilterList from './FilterList';

const Wrapper = styled.div`
    position: absolute;
    height: fit-content;
    top: 50px;
    right: ${(props) => props.right};
    width: 300px;
    border: 1px solid #cccccc;
    border-radius: 5px;
    background-color: #ffffff;
    z-index: 100;
`;

const FilterListWrapper = ({ name, onClick, right, children }) => {
    return (
        <>
            <FilterOverlay onClick={onClick} />
            <Wrapper right={right}>
                <FilterHeader onClick={onClick}>{children}</FilterHeader>
                <FilterList name={name}/>
            </Wrapper>
        </>
    );
};

export default FilterListWrapper;