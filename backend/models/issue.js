module.exports = (sequelize, DataTypes) => {
  return sequelize.define(
    'issue',
    {
      title: {
        type: DataTypes.STRING(45),
        allowNull: false,
      },
      status: {
        type: DataTypes.ENUM('open', 'closed'),
        allowNull: false,
        defaultValue: 'open',
      },
    },
    {
      underscored: true,
      tableName: 'issue',
      paranoid: true,
      timestamps: true,
    }
  );
};
