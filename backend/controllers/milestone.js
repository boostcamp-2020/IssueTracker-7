const milestoneService = require('../services/milestone');

exports.getAll = async (req, res) => {
  const { status, data } = await milestoneService.getAll();
  return res.status(status).json(data);
};

exports.add = async (req, res) => {
  const { status, data } = await milestoneService.create(req.body);
  return res.status(status).json(data);
};

exports.update = async (req, res) => {
  const { status, data } = await milestoneService.update(req.params, req.body);
  return res.status(status).json(data);
};

exports.delete = async (req, res) => {
  const { status, data } = await milestoneService.delete(req.params);
  return res.status(status).json(data);
};
