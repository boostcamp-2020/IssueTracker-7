import React, { useEffect } from 'react';
import { useLabel } from '@stores/label';
import { request } from '@utils/request';
import { useMilestone } from '@stores/milestone';
import { useUser } from '@stores/user';
import styled from 'styled-components';
import A from '@atoms/';
import M from '@molecules/';

const FilterBox = styled.div`
  height: 60px;
  margin: 15px auto 0 auto;
  border: 1px solid #d6d8db;
  border-top-left-radius: 4px;
  border-top-right-radius: 4px;
  background-color: #eaecef;
  display: flex;
  flex-direction: ${(props) => props.direction || 'row'};
  justify-content: flex-end;

  ${A.FlexBox} {
    padding-top: 20px;
    padding-left: 12px;
  }
  ${A.FlexItem} {
    justify-content: flex-end;
  }
`;

const filters = [
  {
    name: 'Author',
    title: 'Filter by author',
    right: '300px',
  },
  {
    name: 'Label',
    title: 'Filter by label',
    right: '200px',
  },
  {
    name: 'Milestones',
    title: 'Filter by milestone',
    right: '100px',
  },
  {
    name: 'Assignee',
    title: 'Filter by assignee',
    right: '50px',
  },
];

const Filter = () => {
  const { labelDispatch } = useLabel();
  const { userDispatch } = useUser();
  const { milestoneDispatch } = useMilestone();

  useEffect(async () => {
    const labelResponse = await request('GET', `/api/label`);
    labelDispatch({
      type: 'GET',
      data: labelResponse.data,
    });
    const userResponse = await request('GET', '/api/user');
    userDispatch({
      type: 'GET',
      data: userResponse.data,
    });
    const milestoneResponse = await request('GET', '/api/milestone');
    milestoneDispatch({
      type: 'GET',
      data: milestoneResponse.data,
    });
  }, []);
  const contents = filters.map((filter) => {
    return (
      <M.DropdownButton name={filter.name} key={filter.name} right={filter.right}>
        {filter.title}
      </M.DropdownButton>
    );
  });
  return (
    <FilterBox direction="row">
      <A.FlexBox>
        <A.CheckBox type="checkbox" />
      </A.FlexBox>
      <A.FlexItem>{contents}</A.FlexItem>
    </FilterBox>
  );
};

export default Filter;
