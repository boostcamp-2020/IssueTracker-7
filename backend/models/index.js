const path = require('path');
const Sequelize = require('sequelize');

const env = process.env.NODE_ENV || 'development';
const config = require(path.join(__dirname, '..', 'config', 'sequelize.js'))[env];
const db = {};

const sequelize = new Sequelize(config.database, config.username, config.password, config);

db.sequelize = sequelize;
db.Sequelize = Sequelize;

db.User = require('./user')(sequelize, Sequelize);
db.Comment = require('./comment')(sequelize, Sequelize);
db.Issue = require('./issue')(sequelize, Sequelize);
db.Label = require('./label')(sequelize, Sequelize);
db.Milestone = require('./milestone')(sequelize, Sequelize);

db.User.belongsToMany(db.Issue, {
  through: 'assignees',
});
db.Issue.belongsToMany(db.User, {
  through: 'assignees',
});

db.User.hasMany(db.Comment, {
  foreignKey: 'user_id',
  sourceKey: 'id',
});
db.Comment.belongsTo(db.User, {
  foreignKey: 'user_id',
  sourceKey: 'id',
});

db.User.hasMany(db.Issue, {
  foreignKey: 'user_id',
  sourceKey: 'id',
});
db.Issue.belongsTo(db.User, {
  foreignKey: 'user_id',
  targetKey: 'id',
});

db.Issue.hasMany(db.Comment, {
  foreignKey: 'issue_id',
  sourceKey: 'id',
});
db.Comment.belongsTo(db.Issue, {
  foreignKey: 'issue_id',
  sourceKey: 'id',
});

db.Milestone.hasMany(db.Issue, {
  foreignKey: 'milestone_id',
  sourceKey: 'id',
});
db.Issue.belongsTo(db.Milestone, {
  foreignKey: 'milestone_id',
  targetKey: 'id',
});

db.Issue.belongsToMany(db.Label, {
  through: 'label_has_issue',
});
db.Label.belongsToMany(db.Issue, {
  through: 'label_has_issue',
});
module.exports = db;
