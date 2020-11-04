const { Label } = require('../models');

exports.get = (req, res) => {
    Label.findAll({
        attributes: ['id', 'name', 'description', 'color']
    }).then(labels => res.status(200).json(labels))
    .catch(err => res.status(401).send('유효하지 않은 요청입니다.'))
};