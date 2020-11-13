import React from 'react';
import { faBook } from '@fortawesome/free-solid-svg-icons';
import A from '@atoms/';

const HeaderTitle = ({ title }) => {
  return (
    <A.Text color="white">
      <A.Icon icon={faBook} inverse />
      &nbsp;{title}
    </A.Text>
  );
};

export default HeaderTitle;
