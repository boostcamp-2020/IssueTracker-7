'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('label', [
      {
        id: 1,
        name: 'frontend',
        description: '',
        color: '#000000',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      }, {
        id: 2,
        name: 'backend',
        description: '',
        color: '#cccccc',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      }, {
        id: 3,
        name: 'environment',
        description: '',
        color: '#ffffff',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      }, {
        id: 4,
        name: 'iOS',
        description: '',
        color: '#eeeeee',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      }, {
        id: 5,
        name: 'feature',
        description: '',
        color: '#aaaaaa',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      }, {
        id: 6,
        name: 'scrum',
        description: '',
        color: '#bbbbbb',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      }, {
        id: 7,
        name: 'wrap-up',
        description: '',
        color: '#dddddd',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      }, {
        id: 8,
        name: 'bug',
        description: '',
        color: '#111111',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      }, {
        id: 9,
        name: 'refactor',
        description: '',
        color: '#c6c6c6',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      }, {
        id: 10,
        name: 'docs',
        description: '',
        color: '#e7e7e7',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      }, {
        id: 11,
        name: 'style',
        description: '',
        color: '#cecece',
        created_at: '2020-10-28',
        updated_at: '2020-10-28'
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('label', null, {});
  }
};