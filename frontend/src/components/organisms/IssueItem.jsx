import React from 'react';
import styled from 'styled-components';
import IssueInfo from '@molecules/IssueInfo';
import Label from '@molecules/Label';
import IssueStatusIcon from '@molecules/IssueStatusIcon';
import CheckBox from '@atoms/CheckBox';
import FlexBox from '@atoms/FlexBox';
import FlexItem from '@atoms/FlexItem';

const IssueTitle = ({ title }) => <Bold>{title}</Bold>;
const IssueItemContainer = styled.li`
  background-color: white;
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

const Bold = styled.span`
  font-weight: 800;
`;

const getLabels = (labels) => labels.map((label) => <Label key={label.id} {...label} />);
const IssueItem = ({
  id,
  title,
  status,
  updatedAt,
  createdAt,
  milestone,
  author,
  labels,
  assignees,
}) => {
  return (
    <IssueItemContainer>
      <FlexBox direction="row">
        <FlexItem>
          <CheckBox type="checkbox" />
        </FlexItem>
        <IssueStatusIcon status={status} inverse />
        <FlexBox direction="column">
          <FlexBox direction="row">
            <IssueTitle title={title} />
            {getLabels(labels)}
          </FlexBox>
          <FlexBox direction="row">
            <IssueInfo
              id={id}
              status={status}
              created_at={createdAt}
              author={author}
              milestone={milestone?.title}
            />
          </FlexBox>
        </FlexBox>
      </FlexBox>
    </IssueItemContainer>
  );
};
export default IssueItem;
