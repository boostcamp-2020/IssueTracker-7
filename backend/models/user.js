module.exports = (sequelize, DataTypes) => {
  return sequelize.define(
    'user',
    {
      user_id: {
        type: DataTypes.STRING(20),
        allowNull: false,
        unique: true,
      },
      password: {
        type: DataTypes.STRING(88),
        allowNull: false,
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
