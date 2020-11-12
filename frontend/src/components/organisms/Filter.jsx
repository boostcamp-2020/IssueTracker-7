import React from 'react';
import styled from 'styled-components';
import M from '@molecules/';

const FilterBox = styled.div`
    width: 90%;
    height: 60px;
    margin: 50px auto 0 auto;
    border: 1px solid #919191;
    border-radius: 4px;
    background-color: #f3f3f3;
    display:flex;
    flex-direction:${(props) => props.direction || "row"};
    justify-content: flex-end;
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
        <FilterBox direction="row">{contents}</FilterBox>
    );
};

export default Filter;