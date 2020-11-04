import React from "react";
import styled from "styled-components";

const FlexBox = styled.div`
display:flex;
flex-direction:${(props)=>props.direction || "row"};
justify-contents:
`
export default FlexBox;