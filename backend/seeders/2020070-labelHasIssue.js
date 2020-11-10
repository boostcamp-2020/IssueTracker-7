'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('label_has_issue', [
      {
        label_id: 2,
        issue_id: 1,
        created_at: '2020-10-29',
        updated_at: '2020-10-29',
      },{
        label_id: 5,
        issue_id: 1,
        created_at: '2020-10-29',
        updated_at: '2020-10-29',
      },{
        label_id: 1,
        issue_id: 4,
        created_at: '2020-10-29',
        updated_at: '2020-10-29',
      },{
        label_id: 5,
        issue_id: 4,
        created_at: '2020-10-29',
        updated_at: '2020-10-29',
      },{
        label_id: 2,
        issue_id: 2,
        created_at: '2020-10-29',
        updated_at: '2020-10-29',
      },{
        label_id: 5,
        issue_id: 2,
        created_at: '2020-10-29',
        updated_at: '2020-10-29',
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('label_has_issue', null, {});
  }
};
