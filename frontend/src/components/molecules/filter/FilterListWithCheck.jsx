import React, { useState } from 'react';
import styled from 'styled-components';
import Check from '../../atoms/filter/Check';
import Uncheck from '../../atoms/filter/Uncheck';

const List = styled.div`
    display: flex;
    height: 35px;
    margin: 0;
    background-color: ${(props) => props.backgroundColor};
    border: none;
    &:hover {
        background-color: #EAECEF;
        cursor: pointer;
    }
`;

const FilterListWithCheck = ({ children }) => {
    const [check, setCheck] = useState(false)
    
    return (
        <>
            { check ?
                <List onClick={() => { setCheck(false) }} backgroundColor='#EAECEF'><Check />{children}</List>
                : <List onClick={() => { setCheck(true) }}><Uncheck />{children}</List>
            }
        </>
    );
};


export default FilterListWithCheck;