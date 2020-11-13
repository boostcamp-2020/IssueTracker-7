import React from 'react';
import styled from 'styled-components';
import A from '@atoms/';
import M from '@molecules/';
import { useLabel } from '@stores/label';
import { useUser } from '@stores/user';
import { useMilestone } from '@stores/milestone';
import { useFilter } from '@stores/filter';

const filters = [
  {
    text: 'Open issues',
    type: 'is',
    value: 'open',
  },
  {
    text: 'Your issues',
    type: 'author',
    value: '@me',
  },
  {
    text: 'Everything assigned to you',
    type: 'assignee',
    value: '@me',
  },
  {
    text: 'Everything mentioning you',
    type: 'mentions',
    value: '@me',
  },
  {
    text: 'Closed issues',
    type: 'is',
    value: 'closed',
  },
];

const Wrapper = styled.div`
  width: 300px;
  height: 35px;
`;

const UserId = styled.span`
  font-size: 13px;
  font-weight: bold;
  padding: 7px 5px;
`;

const LabelInfo = styled.div`
  display: block;
`;

const Info = styled.div`
  display: flex;
  height: 14px;
`;

const Color = styled.div`
  width: 14px;
  height: 14px;
  margin-top: 3px;
  margin-left: 30px;
  background-color: ${(props) => props.backgroundColor};
  border-radius: 4px;
`;

const LabelName = styled.span`
  height: fit-content;
  font-size: 11px;
  font-weight: bold;
  margin: 3px 0 0 5px;
`;

const Description = styled.div`
  font-size: 11px;
  margin-left: 50px;
`;

const DefaultText = styled.span`
  margin-left: 30px;
  margin-top: 5px;
`;

const DropdownList = ({ name }) => {
  if (name === 'Author' || name === 'Assignee') {
    const userList = userInfo
      .sort((a, b) => {
        return a.user_id < b.user_id ? -1 : a.user_id > b.user_id ? 1 : 0;
      })
      .map((user) => {
        return (
          <Wrapper key={user.user_id}>
            <A.Hr />
            <M.DropdownWithCheck>
              <A.Photo src={user.photo_url}></A.Photo>
              <UserId>{user.user_id}</UserId>
            </M.DropdownWithCheck>
          </Wrapper>
        );
      });
    return <>{userList}</>;
  } else if (name === 'Label') {
    const labelList = labelInfo
      .sort((a, b) => {
        return a.name < b.name ? -1 : a.name > b.name ? 1 : 0;
      })
      .map((label) => {
        return (
          <Wrapper key={label.id}>
            <A.Hr />
            <M.DropdownWithCheck key={label.id}>
              <LabelInfo>
                <Info>
                  <Color backgroundColor={label.color}></Color>
                  <LabelName>{label.name}</LabelName>
                </Info>
                <Description>{label.description}</Description>
              </LabelInfo>
            </M.DropdownWithCheck>
          </Wrapper>
        );
      });
    return <>{labelList}</>;
  } else if (name === 'Milestone') {
    const milestoneList = milestoneInfo
      .sort((a, b) => {
        return a.title < b.title ? -1 : a.title > b.title ? 1 : 0;
      })
      .map((milestone) => {
        return (
          <Wrapper key={milestone.id}>
            <A.Hr />
            <M.DropdownWithCheck>
              <DefaultText>{milestone.title}</DefaultText>
            </M.DropdownWithCheck>
          </Wrapper>
        );
      });
    return <>{milestoneList}</>;
  } else {
    const filterList = filters.map((filter, index) => {
      return (
        <Wrapper key={index}>
          <A.Hr />
          <M.DropdownWithCheck type={filter.type} value={filter.value} onClick={handleOnClick}>
            <DefaultText>{filter.text}</DefaultText>
          </M.DropdownWithCheck>
        </Wrapper>
      );
    });
    return <>{filterList}</>;
  }
};

export default DropdownList;
