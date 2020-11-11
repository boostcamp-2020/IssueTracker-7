import React from "react";
import styled from "styled-components";

const Label = styled.p`
  margin-bottom: 5px;
  font-weight: bold;
  font-size: 15px;
`;
const Input = styled.input`
  width: 250px;
  height: 25px;
  border: 1px solid #d6d8db;
`;
const InputBox = ({label, ...options}) => {
  return (
    <label>
      <Label>{label}</Label>
      <Input {...options}/>
    </label>
  );
};

export default InputBox;