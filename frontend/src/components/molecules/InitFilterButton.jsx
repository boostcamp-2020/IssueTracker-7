import React from 'react';
import A from '@atoms/';
import styled from 'styled-components';
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faWindowClose } from '@fortawesome/free-solid-svg-icons';


const Wrapper = styled.div`
    width: 400px;
    margin-top: 10px;
`;

const InitFilterButton = ({ label, ...options }) => {
    
    const handleClick = () => {

    }
    return (
        <Wrapper>
            <A.Button onClick={handleClick}  backgroundColor='#FFFFFF'>
            <FontAwesomeIcon icon={faWindowClose} />
            Clear current search query, filters, and sorts
            </A.Button>
        </Wrapper>
    
  );
};

export default InitFilterButton;
