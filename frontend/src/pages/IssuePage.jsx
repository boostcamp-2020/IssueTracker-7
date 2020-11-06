import React, {useEffect} from "react";
import {request} from '@utils/request'
import IssueList from '@components/issue/IssueList'
import FlexBox from '@components/common/FlexBox'

const IssuePage = () => {
    useEffect(() => {
        {request('GET', '/api/auth/token', {}, ({status, data})=>{
            if(!data.accessToken) {location.href = '/login'}
        })}
    }, [])
    return (
        <FlexBox>
            <IssueList />
        </FlexBox>
    );
  }
export default IssuePage;
