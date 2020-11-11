import React from 'react';
import Input from '@atoms/Input';
import Label from '@atoms/Label';

const InputBox = ({ label, ...options }) => {
  return (
    <label>
      <Label>{label}</Label>
      <Input {...options} />
    </label>
  );
};

export default InputBox;
