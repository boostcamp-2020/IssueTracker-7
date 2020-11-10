import React from 'react';
import styled from 'styled-components';
import HeaderTitle from '@molecules/HeaderTitle';
import ColorSpace from '@atoms/ColorSpace';

const Header = () => {
  return (
    <ColorSpace backgroundColor="black">
      <HeaderTitle title="ISSUES" />
    </ColorSpace>
  );
};

export default Header;
