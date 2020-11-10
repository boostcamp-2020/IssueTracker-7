'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('issue', [
      {
        id: 1,
        title: '회원가입 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 1,
        milestone_id: 1
      }, {
        id: 2,
        title: '로그인 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 1,
        milestone_id: 1
      }, {
        id: 3,
        title: '로그아웃 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 2,
        milestone_id: 1
      }, {
        id: 4,
        title: '로그인 페이지 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 2,
        milestone_id: 1
      }, {
        id: 5,
        title: '이슈 생성 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 2,
        milestone_id: 1
      }, {
        id: 6,
        title: '이슈 조회 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 3,
        milestone_id: 2
      },{
        id: 7,
        title: '이슈 필터 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 4,
        milestone_id: 2
      }, {
        id: 8,
        title: '마일스톤 생성 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 4,
        milestone_id: 3
      }, {
        id: 9,
        title: '마일스톤 조회 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
      }, {
        id: 10,
        title: '레이블 생성 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
      }, {
        id: 11,
        title: '레이블 조회 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('issue', null, {});
  },
};
