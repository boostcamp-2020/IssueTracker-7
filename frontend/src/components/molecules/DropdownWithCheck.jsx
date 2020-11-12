import React, { useState } from 'react';
import styled from 'styled-components';
import A from '@atoms/';

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
                <List onClick={() => { setCheck(false) }} backgroundColor='#EAECEF'><A.Check />{children}</List>
                : <List onClick={() => { setCheck(true) }}><A.Uncheck />{children}</List>
            }
        </>
    );
};


export default FilterListWithCheck;