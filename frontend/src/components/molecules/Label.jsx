import React from 'react';
import A from '@atoms/';
const Label = ({ name, color }) => <A.ColorSpan color={color}>{name}</A.ColorSpan>;

export default Label;
