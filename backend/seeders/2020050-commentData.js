'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('comment', [
      {
        id: 1,
        content: '회원가입을 위한 API를 구현한다.',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 1,
        issue_id: 1
      }, {
        id: 2,
        content: '일반 로그인을 할 수 있다.',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 1,
        issue_id: 2
      },{
        id: 3,
        content: '로그아웃을 할 수 있다.',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 2,
        issue_id: 3
      }, {
        id: 4,
        content: '리액트 기반의 페이지 구현',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 2,
        issue_id: 4
      }, {
        id: 5,
        content: '새로운 이슈를 생성할 수 있다.',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 2,
        issue_id: 5
      }, {
        id: 6,
        content: '이슈 내용을 확인할 수 있다.',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 3,
        issue_id: 6
      }, {
        id: 7,
        content: '필터로 이슈를 검색할 수 있다.',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 4,
        issue_id: 7
      }, {
        id: 8,
        content: '새로운 마일스톤을 생성할 수 있다.',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 4,
        issue_id: 8
      }, {
        id: 9,
        content: '마일스톤의 내용을 확인할 수 있다.',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
        issue_id: 9
      }, {
        id: 10,
        content: '새로운 레이블을 생성할 수 있다.',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
        issue_id: 10
      }, {
        id: 11,
        content: '레이블 내용을 확인할 수 있다.',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
        issue_id: 11
      }, {
        id: 12,
        content: '비밀번호는 8자리 이상이어야한다.',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 4,
        issue_id: 1
      }, {
        id: 13,
        content: '아이디에 특수문자는 포함할 수 없다.',
        created_at: '2020-10-29',
        updated_at: '2020-10-29',
        user_id: 3,
        issue_id: 1
      }, {
        id: 14,
        content: '깃허브 로그인을 할 수 있다.',
        created_at: '2020-10-29',
        updated_at: '2020-10-29',
        user_id: 2,
        issue_id: 2
      }, {
        id: 15,
        content: '애플 계정 로그인을 할 수 있다',
        created_at: '2020-10-30',
        updated_at: '2020-10-30',
        user_id: 3,
        issue_id: 2
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('comment', null, {});
  }
};
