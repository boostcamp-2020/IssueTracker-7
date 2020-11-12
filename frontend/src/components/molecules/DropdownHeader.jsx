import React from 'react';
import styled from 'styled-components';
import A from '@atoms/';

const Header = styled.div`
    display: flex;
    margin: 0;
`;

const DropdownHeader = ({ onClick, children }) => {
    return (
        <Header>
            <A.DropdownTitle>{children}</A.DropdownTitle>
            <A.CloseButton onClick={onClick} />
        </Header>
    );
};

export default DropdownHeader;