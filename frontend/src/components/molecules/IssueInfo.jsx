import React from 'react';
import Text from '@atoms/Text';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSign } from '@fortawesome/free-solid-svg-icons';

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

const MilestoneInfo = ({ milestone }) => {
  return (
    <span stlye="margin: 0 8px">
      {milestone && <FontAwesomeIcon icon={faSign} />}
      {milestone ? milestone : ''}
    </span>
  );
};

const IssueInfo = ({ id, status, created_at, author, milestone }) => {
  return (
    <Text color="gray">
      #{id} {status} {getAgoTime(created_at)} by {author?.user_id}{' '}
      <MilestoneInfo milestone={milestone} />
    </Text>
  );
};

export default IssueInfo;
