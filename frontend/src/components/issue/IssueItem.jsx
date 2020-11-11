import React from "react";
import styled from 'styled-components';
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faExclamationCircle } from '@fortawesome/free-solid-svg-icons';
import FlexBox from '@components/common/FlexBox'
import FlexItem from '@components/common/FlexItem'


const ColorSpan = styled.div`
    background-color: ${(props=>props.color) || "#ffffff"};
    color: ${props=> (props.color>"#fff000")? "black": "white"};
    padding: 0 4px;
    font-weight:800;
    margin: 0 8px;
`
const IssueStatusIcon = ({status}) => <span><FontAwesomeIcon icon={faExclamationCircle} color="#6ca972"/></span>
const IssueTitle = ({title}) => <Bold>{title}</Bold>
const IssueLabel = ({title, color}) => <ColorSpan color={color}>{title}</ColorSpan> 
const IssueItemContainer = styled.div`
    display:flex;
    flex-grow: 1;
    background-color:white;
    border: 1px solid #d6d8db;
    padding: 10px 0;
    &:hover {
        background-color: #eeeeee;
    }
    ${FlexBox} {
        margin: 0 4px;
    }
    ${FlexItem} {
        margin: 0 8px;
    }
`;
const getAgoTime = (time) => {
    let agoSeconds = Math.floor((Date.now() - Date.parse(time)) / 1000)
    let agoMinute = Math.floor(agoSeconds / 60)
    let agoHours = Math.floor(agoMinute / 60)
    let agoDay = Math.floor(agoHours / 24)
    if (agoDay > 0) return `${agoDay} days ago`
    else if (agoHours > 0) return `${agoHours} hours ago`
    else if (agoMinute > 0) return `${agoMinute} minute ago`
    else return `${agoSeconds<0?0:agoSeconds} seconds ago`
}
const Bold = styled.span`
font-weight:800;
`
const GrayText = styled.span`
color:#7f7f7f;
`
const IssueInfo = ({id, status, created_at, author, milestone}) => {
    return (
    <GrayText>#{id} {status} {getAgoTime(created_at)} by {author} {milestone?milestone:''}</GrayText>
    )
}
const IssueItem = ({id, title, status, milestone, author, labels, assignnes}) => {
    return (
    <IssueItemContainer>
        <FlexBox direction="row">
            <FlexItem><input type="checkbox"/></FlexItem>
            <IssueStatusIcon status="open" inverse />
            <FlexBox direction="column">
                <FlexBox direction="row">
                    <IssueTitle title="목록보기 구현"/>
                    <IssueLabel title="bug" color="#ff0000"/>
                </FlexBox>
                <FlexBox direction="row">
                    <IssueInfo id="1" status="opened" created_at="2020-11-04" author="camper" milestone="스프린트2" />
                </FlexBox>
            </FlexBox>
        </FlexBox>
    </IssueItemContainer>
    );
  }
export default IssueItem;