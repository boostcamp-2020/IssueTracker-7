const crypto = require('crypto');

exports.pbkdf2 = (value, salt) => crypto.pbkdf2Sync(value, salt, 100000, 64, 'sha512').toString('base64');