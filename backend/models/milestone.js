module.exports = (sequelize, DataTypes) => {
  return sequelize.define(
    'milestone',
    {
      title: {
        type: DataTypes.STRING(100),
        allowNull: false,
        unique: true,
      },
      due_date: {
        type: DataTypes.DATEONLY,
        allowNull: false,
      },
      description: {
        type: DataTypes.STRING(400),
        allowNull: false,
        defaultValue: '',
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
