import React from 'react';
import styled from 'styled-components';
import M from '@molecules/';
import A from '@atoms/';

const IssueItemContainer = styled.li`
  background-color: white;
  border: 1px solid #d6d8db;
  padding: 10px 0;
  &:hover {
    background-color: #eeeeee;
  }
  ${A.FlexBox} {
    margin: 0 4px;
  }
  ${A.FlexItem} {
    margin: 0 8px;
    justify-content: flex-end;
    margin-right: 120px;
  }
`;

const getAssignees = (assignees) =>
  assignees.map((assignee) => <M.ProfileImage key={assignee.id} {...assignee} />);
const IssueItem = (props) => {
  return (
    <IssueItemContainer>
      <A.FlexBox direction="row">
        <A.FlexBox direction="row">
          <A.FlexBox>
            <A.CheckBox type="checkbox" />
          </A.FlexBox>
          <A.FlexBox>
            <M.IssueStatusIcon status={props.status} inverse />
          </A.FlexBox>
        </A.FlexBox>
        <M.IssueInfo {...props} />
        <A.FlexItem>{getAssignees(props.assignees)}</A.FlexItem>
      </A.FlexBox>
    </IssueItemContainer>
  );
};
export default IssueItem;
