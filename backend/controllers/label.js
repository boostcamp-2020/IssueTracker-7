const labelService = require('../services/label');

exports.getAll = async (req, res) => {
  const labels = await labelService.getAll();
  if (labels) res.json(labels);
  res.status(401).json('유효하지 않은 요청입니다.');
};

exports.add = async (req, res) => {
  const newLabel = req.body;
  const result = await labelService.create(newLabel);
  res.json(result);
};

exports.update = async (req, res) => {
  const { status, data } = await labelService.update(req.params, req.body);
  res.status(status).json(data);
};
