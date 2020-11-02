'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('user', [
      {
        id: 1,
        user_id: '12322445',
        type: 'github',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
      },
      {
        id: 2,
        user_id: '21223467',
        type: 'github',
        created_at: '2020-10-27',
        updated_at: '2020-10-27',
      },
      {
        id: 3,
        user_id: '98372834',
        type: 'github',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
      },
      {
        id: 4,
        user_id: '43243231',
        type: 'github',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
      },
      {
        id: 5,
        user_id: '98778990',
        type: 'github',
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
      },
      {
        id: 6,
        user_id: '44773628',
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
