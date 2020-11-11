import React from 'react';
import IssueInfo from '@molecules/IssueInfo';

export default {
  title: 'molecules/IssueInfo',
  component: IssueInfo,
  argTypes: {
    children: image,
  },
};

const Template = (args) => <IssueInfo {...args} />;

export const Primary = Template.bind({});
Primary.args = {
  id: 1,
  status: open,
  created_at: '2020-02-10',
  author: {
    user_id: 'tester',
  },
};
