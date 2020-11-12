import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faGithub } from '@fortawesome/free-brands-svg-icons';
import A from '@atoms/';

const GithubButton = ({ onClick }) => {
  return (
    <A.Button onClick={onClick} backgroundColor="#a0a0a0">
      Sign with GitHub <FontAwesomeIcon icon={faGithub} color="black" size="lg" />
    </A.Button>
  );
};

export default GithubButton;
