import React from 'react';
import A from '@atoms/';
import styled from 'styled-components';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faWindowClose } from '@fortawesome/free-solid-svg-icons';
import { useFilter } from '@stores/filter';

const Wrapper = styled.div`
  display: ${(props) => props.display};
  margin-top: 15px;
  padding: 0;
  ${A.Button} {
    text-align: left;
    font-size: 16px;
    color: gray;
    & svg {
      margin-right: 8px;
    }
  }
`;
const isInitFilter = (filters) =>
  Object.keys(filters).every((type) => type == 'is') &&
  filters.is?.every((value) => value === 'issue' || value === 'open');
const InitFilterButton = ({ label, ...options }) => {
  const { filters, query, filterDispatch } = useFilter();
  const handleClick = () => {
    filterDispatch({
      type: 'init',
    });
  };
  return (
    <Wrapper display={isInitFilter(filters) ? 'none' : 'block'}>
      <A.Button onClick={handleClick} backgroundColor="#FFFFFF">
        <FontAwesomeIcon icon={faWindowClose} />
        Clear current search query, filters, and sorts
      </A.Button>
    </Wrapper>
  );
};

export default InitFilterButton;
