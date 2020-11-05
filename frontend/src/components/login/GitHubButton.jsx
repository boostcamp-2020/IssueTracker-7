import React from 'react';
import styled from 'styled-components';

const Button = styled.button`
    width: 100%;
    height: 33px;
    font-weight: bold;
    color: #ffffff;
    background-color: #a3a3a3;
    border-radius: 3px;
    border: none;
    outline: none;
    cursor: pointer;
`;

const GithubButton = ({ onClick, children }) => {
    return (
        <Button onClick={onClick}>{children}</Button>
    );
};

export default GithubButton;