const { authorize } = require('passport');
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

db.User.hasMany(db.Issue, {
  as: 'written',
  foreignKey: 'user_id',
  sourceKey: 'id',
});
db.User.belongsToMany(db.Issue, {
  as: 'assigned',
  through: 'user_has_issue',
});
db.User.hasMany(db.Comment, {
  as: 'comments',
  foreignKey: 'user_id',
  sourceKey: 'id',
});

db.Issue.belongsToMany(db.User, {
  as: 'assignees',
  through: 'user_has_issue',
});
db.Issue.belongsTo(db.User, {
  as: 'author',
  foreignKey: 'user_id',
  targetKey: 'id',
});
db.Issue.hasMany(db.Comment, {
  foreignKey: 'issue_id',
  sourceKey: 'id',
});
db.Issue.belongsTo(db.Milestone, {
  foreignKey: 'milestone_id',
  targetKey: 'id',
});
db.label_has_issue = sequelize.define(
  'label_has_issue',
  {},
  { underscored: true, tableName: 'label_has_issue', timestamps: true }
);
db.Issue.hasMany(db.label_has_issue, {
  foreignKey: 'issue_id',
  sourceKey: 'id',
});
db.Issue.belongsToMany(db.Label, {
  as: 'labels',
  through: db.label_has_issue,
});

db.label_has_issue.belongsTo(db.Label, {
  foreignKey: 'label_id',
  targetKey: 'id',
});
db.label_has_issue.belongsTo(db.Issue, {
  foreignKey: 'issue_id',
  targetKey: 'id',
});

db.Label.hasMany(db.label_has_issue, {
  foreignKey: 'label_id',
  sourceKey: 'id',
});
db.Label.belongsToMany(db.Issue, {
  as: 'issues',
  through: db.label_has_issue,
});

db.Comment.belongsTo(db.User, {
  as: 'mentions',
  foreignKey: 'user_id',
  targetKey: 'id',
});
db.Comment.belongsTo(db.Issue, {
  foreignKey: 'issue_id',
  targetKey: 'id',
});

db.Milestone.hasMany(db.Issue, {
  foreignKey: 'milestone_id',
  sourceKey: 'id',
});

module.exports = db;
