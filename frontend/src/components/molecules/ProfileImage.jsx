import React from 'react';
import A from '@atoms/';

const ProfileImage = ({ photo_url }) => {
  return <A.Image src={photo_url} width="25px" height="25px" />;
};

export default ProfileImage;
