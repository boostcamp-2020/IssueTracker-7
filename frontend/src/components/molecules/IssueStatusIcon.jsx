import React from 'react';
import { faExclamationCircle } from '@fortawesome/free-solid-svg-icons';
import A from '@atoms/';

const IssueStatusIcon = ({ status }) => <A.Icon icon={faExclamationCircle} color="#6ca972" />;
export default IssueStatusIcon;
