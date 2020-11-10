'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('user_has_issue', [
      {
        user_id: 1,
        issue_id: 1,
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
      },{
        user_id: 2,
        issue_id: 1,
        created_at: '2020-10-29',
        updated_at: '2020-10-29',
      },{
        user_id: 3,
        issue_id: 1,
        created_at: '2020-10-29',
        updated_at: '2020-10-29',
      },{
        user_id: 2,
        issue_id: 2,
        created_at: '2020-10-28',
        updated_at: '2020-10-28',
      },{
        user_id: 3,
        issue_id: 2,
        created_at: '2020-10-30',
        updated_at: '2020-10-30',
      },{
        user_id: 4,
        issue_id: 2,
        created_at: '2020-10-30',
        updated_at: '2020-10-30',
      },{
        user_id: 1,
        issue_id: 3,
        created_at: '2020-10-29',
        updated_at: '2020-10-29',
      },{
        user_id: 2,
        issue_id: 3,
        created_at: '2020-10-29',
        updated_at: '2020-10-29',
      },{
        user_id: 4,
        issue_id: 4,
        created_at: '2020-10-30',
        updated_at: '2020-10-30',
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('user_has_issue', null, {});
  }
};
