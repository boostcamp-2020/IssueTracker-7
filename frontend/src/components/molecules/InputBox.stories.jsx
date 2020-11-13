import React from 'react';
import InputBox from '@molecules/InputBox';

export default {
  title: 'molecules/InputBox',
  component: InputBox,
};

const Template = (args) => <InputBox {...args} />;

export const Primary = Template.bind({});
Primary.args = {
  label: 'test',
  type: 'text',
};
