module.exports = (sequelize, DataTypes) => {
  return sequelize.define(
    'milestone',
    {
      title: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      due_date: {
        type: DataTypes.DATEONLY,
        allowNull: false,
      },
    },
    {
      underscored: true,
      tableName: 'milestone',
      paranoid: true,
      timestamps: true,
    }
  );
};
