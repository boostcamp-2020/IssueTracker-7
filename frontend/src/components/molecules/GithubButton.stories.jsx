import React from 'react';
import GithubButton from '@molecules/GithubButton';

export default {
  title: 'molecules/GithubButton',
  component: GithubButton,
  argTypes: {},
};

const Template = (args) => <GithubButton {...args} />;

export const Primary = Template.bind({});
Primary.args = {};
