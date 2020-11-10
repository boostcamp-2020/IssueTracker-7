import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faExclamationCircle } from '@fortawesome/free-solid-svg-icons';

const IssueStatusIcon = ({ status }) => (
  <FontAwesomeIcon icon={faExclamationCircle} color="#6ca972" />
);
export default IssueStatusIcon;
