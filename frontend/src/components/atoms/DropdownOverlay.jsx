import React from 'react';
import styled from 'styled-components';

const Div = styled.div`
    width: 100%;
    height: 100%;
    position: fixed;
    z-index: 50;
`;

const FilterOverlay = ({onClick}) => {
    return (
        <Div onClick={onClick} />
    );
};

export default FilterOverlay;