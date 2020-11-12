import React from 'react';
import styled from 'styled-components';
import A from '@atoms/'
import M from '@molecules/';

const FilterBox = styled.div`
    height: 60px;
    margin: 50px auto 0 auto;
    border: 1px solid #d6d8db;
    border-top-left-radius: 4px;
    border-top-right-radius: 4px;
    background-color: #EAECEF;
    display:flex;
    flex-direction:${(props) => props.direction || "row"};
    justify-content: flex-end;

    ${A.FlexBox}{
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
        right: '300px'
    }, {
        name: 'Label',
        title: 'Filter by label',
        right: '200px'
    }, {
        name: 'Milestones',
        title: 'Filter by milestone',
        right: '100px'
    }, {
        name: 'Assignee',
        title: 'Filter by assignee',
        right: '50px'
    }
];

const Filter = () => {
    const contents = filters.map(filter => {
        return <M.DropdownButton name={filter.name} key={filter.name} right={filter.right}>{filter.title}</M.DropdownButton>
    })
    return (
        <FilterBox direction="row">
            <A.FlexBox>
                <A.CheckBox type="checkbox" />
            </A.FlexBox>
            <A.FlexItem>
                {contents}
            </A.FlexItem>
        </FilterBox>
    );
};

export default Filter;