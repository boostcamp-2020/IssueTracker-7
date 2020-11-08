const issueService = require('../services/issue');

exports.getAll = async (req, res) => {
  const { status, data } = await issueService.getFilteredAll(req.query, req.user.user_id);
  res.status(status).json(data);
};

exports.getOne = async (req, res) => {
  const { status, data } = await issueService.getOne(req.params);
  res.status(status).json(data);
};

exports.update = async (req, res) => {
  const { status, data } = await issueService.update(req.params, req.body);
  res.status(status).json(data);
};

exports.add = async (req, res) => {
  const issueParam = req.body;
  const { status, data } = await issueService.create(issueParam);
  res.status(status).json(data);
};

exports.add = async (req, res) => {
  const issueParam = req.body;
  const { status, data } = await issueService.create(issueParam);
  res.status(status).json(data);
};

exports.getMilestone = async (req, res) => {
  const { status, data } = await issueService.getMilestone(req.params);
  res.status(status).json(data);
};

exports.addMilestone = async (req, res) => {
  const { status, data } = await issueService.addMilestone(req.params);
  res.status(status).json(data);
};
