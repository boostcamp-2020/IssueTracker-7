import React from 'react';
import styled from 'styled-components';
import FilterButton from '../molecules/filter/FilterButton';

const FilterBox = styled.div`
    width: 94%;
    height: 60px;
    border:1px solid #919191;
    border-radius: 4px;
    background-color: #f3f3f3;
    margin-left: 3%;
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
        return <FilterButton name={filter.name} key={filter.name} right={filter.right}>{filter.title}</FilterButton>
    })
    return (
        <FilterBox direction="row">{contents}</FilterBox>
    );
};

export default Filter;