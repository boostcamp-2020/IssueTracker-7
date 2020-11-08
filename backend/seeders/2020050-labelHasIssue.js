'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('label_has_issue', [
      {
        issue_id: 1,
        label_id: 1,
        updated_at: '2020-10-20',
        created_at: '2020-10-20',
      },
      {
        issue_id: 1,
        label_id: 2,
        updated_at: '2020-10-20',
        created_at: '2020-10-20',
      },
      {
        issue_id: 1,
        label_id: 4,
        updated_at: '2020-10-20',
        created_at: '2020-10-20',
      },
      {
        issue_id: 2,
        label_id: 1,
        updated_at: '2020-10-20',
        created_at: '2020-10-20',
      },
      {
        issue_id: 2,
        label_id: 2,
        updated_at: '2020-10-20',
        created_at: '2020-10-20',
      },
      {
        issue_id: 3,
        label_id: 1,
        updated_at: '2020-10-20',
        created_at: '2020-10-20',
      },
      {
        issue_id: 3,
        label_id: 3,
        updated_at: '2020-10-20',
        created_at: '2020-10-20',
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('label_has_issue', null, {});
  },
};
