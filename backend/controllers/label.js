const labelService = require('../services/label');

exports.get = async (req, res) => {
    const labels = await labelService.getAll(req.params.issue_id);
    if (labels) {
        res.json(labels);
    } else {
        res.status(401).json('유효하지 않은 요청입니다.');   
    };
};

exports.add = async (req, res) => {
    const newLabel = req.body;
    const result = await labelService.create(newLabel);
    res.json(result);
};