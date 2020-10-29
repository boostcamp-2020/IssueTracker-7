'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('milestone', [
      {
        title: '1주차',
        due_date: '2020-11-03',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      },{
        title: '2주차',
        due_date: '2020-11-10',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      },{
        title: '3주차',
        due_date: '2020-11-17',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      },{
        title: '4주차',
        due_date: '2020-11-24',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      },{
        title: '5주차',
        due_date: '2020-11-30',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      },{
        title: '6주차',
        due_date: '2020-12-07',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('milestone', null, {});
  }
};
