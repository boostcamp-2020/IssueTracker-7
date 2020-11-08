const labelService = require('../services/label');

exports.getAll = async (req, res) => {
  const { status, data } = await labelService.getAll(req.params.issue_id);
  res.status(status).json(data);
};

exports.getOne = async (req, res) => {
  const { status, data } = await labelService.getOne(req.params);
  res.status(status).json(data);
};

exports.add = async (req, res) => {
  const newLabel = req.body;
  const result = await labelService.create(newLabel);
  res.json(result);
};

exports.delete = async (req, res) => {
  const { status, data } = await labelService.delete(req.params);
  res.status(status).json(data);
};

exports.update = async (req, res) => {
  const { status, data } = await labelService.update(req.params, req.body);
  res.status(status).json(data);
};