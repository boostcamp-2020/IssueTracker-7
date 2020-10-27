module.exports = (sequelize, DataTypes) => {
  return sequelize.define(
    'issue',
    {
      title: {
        type: DataTypes.STRING(45),
        allowNull: false,
      },
      comment: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      status: {
        type: DataTypes.ENUM('open', 'closed'),
        allowNull: false,
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
