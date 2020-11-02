'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('issue', [
      {
        title: '회원가입 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
      },
      {
        title: '로그인 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
      },
      {
        title: '로그아웃 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
      },
      {
        title: '깃허브 로그인 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
      },
      {
        title: '이슈 생성 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
      },
      {
        title: '이슈 조회 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
      },
      {
        title: '이슈 생성 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
      },
      {
        title: '이슈 필터 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
      },
      {
        title: '마일스톤 생성 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
      },
      {
        title: '마일스톤 조회 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
      },
      {
        title: '레이블 생성 기능 구현',
        status: 'open',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        user_id: 5,
      },
      {
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
