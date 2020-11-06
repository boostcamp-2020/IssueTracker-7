const { Milestone } = require('../models');

exports.get = (req, res) => {
    Milestone.findAll({
        attributes: ['id', 'title', 'due_date']
    }).then(milestones => res.status(200).json(milestones))
        .catch(err => res.status(401).send('유효하지 않은 요청입니다.'));
} 