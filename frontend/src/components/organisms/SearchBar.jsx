import React from 'react';
import styled from 'styled-components';
import M from '@molecules/';
import A from '@atoms/';
import Wrapper from '../atoms/Wrapper';
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faMapSigns, faTag } from '@fortawesome/free-solid-svg-icons';
import {useFilter} from '@stores/filter'
import {useLabel} from '@stores/label'
import {useMilestone} from '@stores/milestone'


const SearchBarContainer = styled.div`
    width: auto;
    display: flex;
    margin-top: 50px;
    
    ${A.Input} {
        width: 800px;
        height: 33px;
        border-top-right-radius: 4px;
        border-bottom-right-radius: 4px;
        margin-right: 10px;
        padding: 0;
        cursor: text;
        border-color: #d6d8db;
        outline: none;
        background-color: #EAECEF;
        &:focus {
           box-shadow: 0 0 10px 0 #8fbcff;
        }
    }

    ${Wrapper} {
        display: flex;
        width: auto;
        height: fit-content;
        margin: 0 10px;

        ${A.TextButton} {
            display: flex;
            width: 130px;
            padding: 8px 0;
            justify-content: center;
        } 

        ${A.ColorSpan} {
            width: fit-content;
            align-content: center;
            padding: 2px 6px 0 6px;
            padding-bottom: 3px;
            color: #000000;
        }
    }

    ${A.Button} {
        display: flex;
        width: 130px;
        height: 35px;
        justify-content: center;
        padding: 10px 0 0 6px;
        border: 1px solid #d6d8db;
        border-radius: 7px;
    }
`;

const SearchBar = () => {
    const { query } = useFilter();
    const { milestones } = useMilestone();
    const { labels } = useLabel();

    const handleFilters = () => {
        alert('개발 중입니다😥')
    }
    const moveLabel = () => {
        alert('페이지 개발 중입니다😥')
    };

    const moveMilestone = () => {
        alert('페이지 개발 중입니다😥')
    };

    const moveNewIssue = () => {
        alert('페이지 개발 중입니다😥')
    };

    
    return (
        <SearchBarContainer>
            <M.DropdownButton name='Filters' right='900px'>Filters</M.DropdownButton>
            <A.Input value={query}/>
            <Wrapper>
                <A.Button onClick={moveLabel} backgroundColor='#FFFFFF' color='#000000'>
                    <FontAwesomeIcon icon={faTag} />Labels
                    <A.ColorSpan color='#EAECEF'>{labels.length || 0}</A.ColorSpan>
                </A.Button>
                <A.Button onClick={moveMilestone} backgroundColor='#FFFFFF' color='#000000'>
                    <FontAwesomeIcon icon={faMapSigns} /> Milestones
                    <A.ColorSpan color='#EAECEF'>{milestones.length || 0}</A.ColorSpan>
                </A.Button>
            </Wrapper>
            <A.Button onClick={moveNewIssue} backgroundColor='#2C974B' color='#ffffff'>
                New Issue
                {/* <Link to="/new_issue">New Issue</Link> */}
            </A.Button>
        </SearchBarContainer>
    );
};

export default SearchBar;
