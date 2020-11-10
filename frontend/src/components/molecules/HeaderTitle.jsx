import React from 'react';
import Text from '@atoms/Text';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faBook } from '@fortawesome/free-solid-svg-icons';

const HeaderTitle = ({ title }) => {
  return (
    <Text color="white">
      <FontAwesomeIcon icon={faBook} inverse />
      &nbsp;{title}
    </Text>
  );
};

export default HeaderTitle;
