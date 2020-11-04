import React from "react";
import styled from "styled-components";

const Bold = styled.p`
  margin-bottom: 5px;
  font-weight: bold;
  font-size: 15px;
`;
const Input = styled.input`
  width: 250px;
  height: 25px;
`;
const InputBox = (props) => {
  return (
    <label>
      <Bold>{props.title}</Bold>
      <Input
        type={props.type}
        name={props.name}
        minlength={props.minlength}
        maxlength={props.maxlength}
      />
    </label>
  );
};

export default InputBox;