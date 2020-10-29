module.exports = (sequelize, DataTypes) => {
  return sequelize.define(
    'label',
    {
      name: {
        type: DataTypes.STRING(20),
        allowNull: false,
        unique: true,
      },
      description: {
        type: DataTypes.STRING(50),
        allowNull: false,
        defaultValue: '',
      },
      color: {
        type: DataTypes.STRING(10),
        allowNull: false,
      },
    },
    {
      underscored: true,
      tableName: 'label',
      paranoid: true,
      timestamps: true,
    }
  );
};
