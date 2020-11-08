const labelService = require('../services/label');

exports.get = async (req, res) => {
    const { status, data } = await labelService.getAll(req.params.issue_id);
    res.status(status).json(data);
};

exports.add = async (req, res) => {
    const newLabel = req.body;
    const { status, data } = await labelService.create(newLabel);
    res.status(status).json(data);
};