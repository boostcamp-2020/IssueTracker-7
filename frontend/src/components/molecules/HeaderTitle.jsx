import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faBook } from '@fortawesome/free-solid-svg-icons';
import A from '@atoms/';

const HeaderTitle = ({ title }) => {
  return (
    <A.Text color="white">
      <FontAwesomeIcon icon={faBook} inverse />
      &nbsp;{title}
    </A.Text>
  );
};

export default HeaderTitle;
