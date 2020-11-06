import React from "react";
import styled from "styled-components";
import FlexItem from '@components/common/FlexItem'

const TextButton = styled.input`
margin: 15px 5px 20px 5px;
background-color: #ffffff;
color: #397eff;
border: none;
outline: none;
cursor: pointer;
font-size: 14px;
font-weight: bold;
`;
const Button = ({...options}) => {
  return(
    <FlexItem><TextButton {...options}/></FlexItem> 
  );
};

export default Button;