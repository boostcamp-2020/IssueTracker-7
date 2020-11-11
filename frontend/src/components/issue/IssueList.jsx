import React from "react";
import styled from 'styled-components';
import FlexBox from '@components/common/FlexBox'
import IssueItem from '@components/issue/IssueItem'

const IssueListContainer = styled.div`
width:1080px;
`

const IssueList = (props) => {
    return (
    <IssueListContainer>
        <FlexBox direction="column">
            <IssueItem /> 
            <IssueItem /> 
            <IssueItem /> 
        </FlexBox>
    </IssueListContainer>
    );
  };
export default IssueList;