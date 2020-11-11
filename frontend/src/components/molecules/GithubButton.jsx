import React from 'react';
import Button from '@atoms/Button';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faGithub } from '@fortawesome/free-brands-svg-icons';

const GithubButton = ({ onClick }) => {
  return (
    <Button onClick={onClick} backgroundColor="#a0a0a0">
      Sign with GitHub <FontAwesomeIcon icon={faGithub} color="black" size="lg" />
    </Button>
  );
};

export default GithubButton;
