import React from 'react';
import ColorSpan from '@atoms/ColorSpan';

const Label = ({ name, color }) => <ColorSpan color={color}>{name}</ColorSpan>;

export default Label;
