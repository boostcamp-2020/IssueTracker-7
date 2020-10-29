'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    
    await queryInterface.bulkInsert('user', [
      {
      user_id: '12322445',
      type: 'github',
      created_at: '2020-10-28',
      updated_at: '2020-10-28'
    }, {
      user_id: '21223467',
      type: 'github',
      created_at: '2020-10-27',
      updated_at: '2020-10-27'
    }, {
      user_id: '98372834',
      type: 'github',
      created_at: '2020-10-28',
      updated_at: '2020-10-28'
    }, {
      user_id: '43243231',
      type: 'github',
      created_at: '2020-10-28',
      updated_at: '2020-10-28'
    }, {
      user_id: '98778990',
      type: 'github',
      created_at: '2020-10-28',
      updated_at: '2020-10-28'
    }, {
      user_id: '44773628',
      type: 'github',
      created_at: '2020-10-28',
      updated_at: '2020-10-28'
    }
  ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('user', null, {})
  }
};