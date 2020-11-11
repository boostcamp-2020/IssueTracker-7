import React from 'react';
import LoginForm from '@organisms/LoginForm';

export default {
  title: 'organisms/LoginForm',
  component: LoginForm,
  argTypes: {},
};

const Template = (args) => <LoginForm />;

export const Primary = Template.bind({});
Primary.args = {};
