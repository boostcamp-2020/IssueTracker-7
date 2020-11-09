const { User } = require('../models');

exports.getAll = async (req, res) => {
    const { status, data } = await userService.getAll(req.params.issue_id);
    res.status(status).json(data);
};