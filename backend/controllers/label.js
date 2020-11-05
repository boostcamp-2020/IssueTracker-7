const labelService = require('../services/label');

exports.get = async (req, res) => {
    const labels = await labelService.getAll();
    if (labels) res.json(labels);
    res.status(401).json('유효하지 않은 요청입니다.');
};

exports.add = async (req, res) => {
    const newLabel = req.body;
    const label = await labelService.findByName(newLabel);
    
    if (label) res.json(false);
    const result = await labelService.create(newLabel);
    res.json(result);
};