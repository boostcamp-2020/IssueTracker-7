import React from 'react';
import styled from 'styled-components';
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCheck } from '@fortawesome/free-solid-svg-icons';

const Image = styled.div`
    width: 10px;
    height: 10px;
    margin-left: 20px;
    margin-top: 5px;
`;

const Check = () => {
    return (
        <Image><FontAwesomeIcon icon={faCheck} /></Image>
    )
};

export default Check;