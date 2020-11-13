import React from 'react';
import IssueList from '@organisms/IssueList';

export default {
  title: 'organisms/IssueList',
  component: IssueList,
  argTypes: {},
};

const Template = (args) => <IssueList />;

export const Primary = Template.bind({});
Primary.args = {};
