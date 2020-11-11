import React from 'react';
import Text from '@atoms/Text';

export default {
  title: 'atoms/Text',
  component: Text,
};

const Template = (args) => <Text {...args} />;

export const Primary = Template.bind({});
Primary.args = {};
