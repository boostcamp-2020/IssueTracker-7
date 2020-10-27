require('dotenv').config();
const development = {
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    host: process.env.DB_HOST,
    timezone: '+09:00',
    dialect: 'mysql',
    dialectOptions: {
        charset: 'utf8mb4',
        dateStrings: true,
        typeCast: true
    },
    define: {
        timestamps: true
    }
};

module.exports = {
    development,
};