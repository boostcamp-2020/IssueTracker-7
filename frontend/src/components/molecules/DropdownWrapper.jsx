import React from 'react';
import styled from 'styled-components';
import A from '@atoms/';
import M from '@molecules/';

const Wrapper = styled.div`
    position: absolute;
    height: fit-content;
    right: ${(props) => props.right};
    width: 300px;
    margin-top: 60px;
    border: 1px solid #cccccc;
    border-radius: 5px;
    background-color: #ffffff;
    z-index: 100;
`;

const DropdownWrapper = ({ name, onClick, right, children }) => {
    
    return (
        <>
            <A.DropdownOverlay onClick={onClick} />
            <Wrapper right={right}>
                <M.DropdownHeader onClick={onClick}>{children}</M.DropdownHeader>
                <M.Dropdown name={name}/>
            </Wrapper>
        </>
    );
};

export default DropdownWrapper;