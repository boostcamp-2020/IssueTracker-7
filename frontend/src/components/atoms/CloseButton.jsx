import React from "react";
import styled from "styled-components";

const Button = styled.button`
  width: 50px;
  font-size: 15px;
  border: none;
  background-color: #ffffff;
  cursor: pointer;
  outline: none;
`;

const CloseButton = ({onClick}) => {
  return(
    <Button onClick={onClick}>X</Button>
  );
};

export default CloseButton;