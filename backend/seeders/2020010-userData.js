'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('user', [
      {
        id: 1,
        user_id: 'ahnsoheee',
        type: 'github',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        photo_url: 'https://avatars2.githubusercontent.com/u/61968474?v=4',
      },
      {
        id: 2,
        user_id: 'tester',
        type: 'github',
        created_at: '2020-10-27',
        updated_at: '2020-10-27',
        photo_url: 'https://avatars2.githubusercontent.com/u/61968474?v=4',
      },
      {
        id: 3,
        user_id: 'imho',
        type: 'github',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
        photo_url: 'https://avatars2.githubusercontent.com/u/61968474?v=4',
      },
      {
        id: 4,
        user_id: 'sohee',
        type: 'github',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
      },
      {
        id: 5,
        user_id: 'youngmin',
        type: 'github',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
      },
      {
        id: 6,
        user_id: 'namjin',
        type: 'github',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('user', null, {});
  },
};
