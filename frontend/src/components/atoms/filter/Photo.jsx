import React from 'react';
import styled from 'styled-components';

const Image = styled.img`
    width: 25px;
    height: 25px;
    padding: 5px 5px 5px 30px;
`;

const Photo = ({src}) => {
    return <Image src={src} />
};

export default Photo;