import React, {useState } from 'react';
import styled from 'styled-components';
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCaretDown } from "@fortawesome/free-solid-svg-icons";
import M from '@molecules/';

const Button = styled.button`
    width: 100px;
    background-color: #EAECEF;
    border: none;
    font-size: 14px;
    outline: none;
    cursor: pointer;  
`;

const DropdownButton = ({ name, right, children }) => {
    const [visible, setVisible] = useState(false);
    
    const openFilter = () => {
        setVisible(true)
    };
    
    const closeFilter = () => {
        setVisible(false)
    };

    return (
        <>
            <Button onClick={openFilter}>{name} <FontAwesomeIcon icon={faCaretDown} /></Button>
            { visible ? <M.DropdownWrapper name={name} onClick={closeFilter} right={right}>{children}</M.DropdownWrapper> : null}
        </>
    );
};

export default DropdownButton;