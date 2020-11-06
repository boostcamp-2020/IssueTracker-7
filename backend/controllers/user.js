const { User } = require('../models');

exports.get = (req, res) => {
    User.findAll({
        attributes: ['id', 'user_id', 'photo_url', 'type']
    }).then(users => res.status(200).json(users))
        .catch(err => res.status(401).send('유효하지 않은 요청입니다.'));
};