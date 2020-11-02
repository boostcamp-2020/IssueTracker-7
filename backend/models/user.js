module.exports = (sequelize, DataTypes) => {
  return sequelize.define(
    'user',
    {
      user_id: {
        type: DataTypes.STRING(88),
        allowNull: false,
      },
      password: {
        type: DataTypes.STRING(88),
        allowNull: true,
      },
      type: {
        type: DataTypes.STRING(45),
        allowNull: false,
      },
    },
    {
      underscored: true,
      tableName: 'user',
      paranoid: true,
      timestamps: true,
    }
  );
};
