import React from 'react';
import styled from 'styled-components';
import A from '@atoms/';
import M from '@molecules/';

const userInfo = [
    {
        id: 1,
        user_id: 'ahnsoheee',
        photo_url: 'https://avatars2.githubusercontent.com/u/61968474?v=4',
        type: 'github'
    },
    {
        id: 2,
        user_id: 'sohee',
        photo_url: 'https://avatars2.githubusercontent.com/u/61968474?v=4',
        type: 'github'
    }
];

const labelInfo = [
    {
        id: 1,
        name: 'frontend',
        description: 'test',
        color: '#000000'
    }, {
        id: 2,
        name: 'backend',
        description: '',
        color: '#f02929'
    }, {
        id: 3,
        name: 'environment',
        description: '',
        color: '#ffa526'
    }, {
        id: 4,
        name: 'iOS',
        description: '',
        color: '#fffb26'
    }, {
        id: 5,
        name: 'feature',
        description: '',
        color: '#26ffc9'
    }
];

const milestoneInfo = [
    {
        id: 1,
        title: '1주차',
        due_date: '2020-11-03'
    }, {
        id: 2,
        title: '2주차',
        due_date: '2020-11-03==10'
    }, {
        id: 3,
        title: '3주차',
        due_date: '2020-11-17'
    }, {
        id: 4,
        title: '4주차',
        due_date: '2020-11-24'
    }, {
        id: 5,
        title: '5주차',
        due_date: '2020-11-30'
    }
];

const Wrapper = styled.div`
    width:300px;
    height:35px;
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

const MilestoneName = styled.span`
    margin-left: 30px;
    margin-top: 5px;
`;

const Dropdown = ({name}) => {

    if (name === 'Author' || name === 'Assignee') {
        const userList = userInfo.sort((a, b) => {
            return a.user_id < b.user_id ? -1 : a.user_id > b.user_id ? 1 : 0;
        }).map(user => {
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
        return <>{userList}</>
    }
    else if (name === 'Label') {
        const labelList = labelInfo.sort((a, b) => {
            return a.name < b.name ? -1 : a.name > b.name ? 1 : 0;
        }).map(label => {
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
        return <>{labelList}</>
    }
    else {
        const milestoneList = milestoneInfo.sort((a, b) => {
            return a.title < b.title ? -1 : a.title > b.title ? 1 : 0;
        }).map(milestone => {
            return (
                <Wrapper key={milestone.id}>
                    <A.Hr />
                    <M.DropdownWithCheck>
                        <MilestoneName>{milestone.title}</MilestoneName>
                    </M.DropdownWithCheck>
                </Wrapper>
            );
        });
        return <>{milestoneList}</>
    }
}


export default Dropdown;