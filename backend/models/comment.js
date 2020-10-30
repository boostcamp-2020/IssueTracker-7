module.exports = (sequelize, DataTypes) => {
  return sequelize.define(
    'comment',
    {
      content: {
        type: DataTypes.STRING(500),
        allowNull: false,
      },
    },
    {
      underscored: true,
      tableName: 'comment',
      paranoid: true,
      timestamps: true,
    }
  );
};
