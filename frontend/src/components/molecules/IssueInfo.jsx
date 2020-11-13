import React from 'react';
import styled from 'styled-components';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSign } from '@fortawesome/free-solid-svg-icons';
import A from '@atoms/';
import M from '@molecules/';

const getAgoTime = (time) => {
  let agoSeconds = Math.floor((Date.now() - Date.parse(time)) / 1000);
  let agoMinute = Math.floor(agoSeconds / 60);
  let agoHours = Math.floor(agoMinute / 60);
  let agoDay = Math.floor(agoHours / 24);
  if (agoDay > 0) return `${agoDay} days ago`;
  else if (agoHours > 0) return `${agoHours} hours ago`;
  else if (agoMinute > 0) return `${agoMinute} minute ago`;
  else return `${agoSeconds < 0 ? 0 : agoSeconds} seconds ago`;
};
const IssueTitle = ({ title }) => <Bold>{title}</Bold>;
const MilestoneInfo = ({ title }) => {
  return (
    <span stlye="margin: 0 8px">
      {title && <FontAwesomeIcon icon={faSign} />}
      {title ? title : ''}
    </span>
  );
};
const Bold = styled.span`
  font-weight: 800;
`;
const getLabels = (labels) => labels.map((label) => <M.Label key={label.id} {...label} />);

const IssueInfo = ({ id, title, status, labels, createdAt, author, milestone }) => {
  return (
    <A.FlexBox direction="column">
      <A.FlexBox direction="row">
        <IssueTitle title={title} />
        {getLabels(labels)}
      </A.FlexBox>
      <A.FlexBox direction="row">
        <A.Text color="gray">
          #{id} {status} {getAgoTime(createdAt)} by {author?.user_id}{' '}
          <MilestoneInfo {...milestone} />
        </A.Text>
      </A.FlexBox>
    </A.FlexBox>
  );
};
export default IssueInfo;
