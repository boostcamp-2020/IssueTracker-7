import React from 'react';
import A from '@atoms/';

const InputBox = ({ label, ...options }) => {
  return (
    <label>
      <A.Label>{label}</A.Label>
      <A.Input {...options} />
    </label>
  );
};

export default InputBox;
