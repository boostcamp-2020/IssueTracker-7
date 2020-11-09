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

exports.deleteMilestone = async (req, res) => {
  const { status, data } = await issueService.deleteMilestone(req.params);
  res.status(status).json(data);
};

exports.getLabel = async (req, res) => {
  const { status, data } = await issueService.getLabel(req.params.issue_id);
  res.status(status).json(data);
};

exports.addLabel = async (req, res) => {
  const { status, data } = await issueService.addLabel(req.params.issue_id, req.body.label_id);
  res.status(status).json(data);
};

exports.deleteLabel = async (req, res) => {
  const { status, data } = await issueService.deleteLabel(req.params.issue_id, req.params.label_id);
  res.status(status).json(data);
};

exports.getAssigneeAll = async (req, res) => {
  const { status, data } = await issueService.getAssigneeAll(req.params.issue_id);
  res.status(status).json(data);
};

exports.getAssigneeOne = async (req, res) => {
  const { status, data } = await issueService.getAssigneeOne(req.params.issue_id, req.params.assignee_id);
  res.status(status).json(data);
};

exports.addAssignee = async (req, res) => {
  const { status, data } = await issueService.addAssignee(req.params.issue_id, req.body.user_id);
  res.status(status).json(data);
};

exports.deleteAssignee = async (req, res) => {
  const { status, data } = await issueService.deleteAssignee(req.params.issue_id, req.params.assignee_id);
  res.status(status).json(data);
};

exports.getCommentAll = async (req, res) => {
  const { status, data } = await issueService.getCommentAll(req.params.issue_id);
  res.status(status).json(data);
};

exports.getCommentOne = async (req, res) => {
  const params = {
    issue_id: req.params.issue_id,
    comment_id: req.params.comment_id
  }
  const { status, data } = await issueService.getCommentOne(params);
  res.status(status).json(data);
};

exports.addComment = async (req, res) => {
  const params = {
    issue_id: req.params.issue_id,
    content: req.body.content,
    user: req.user
  }
  const { status, data } = await issueService.addComment(params);
  res.status(status).json(data);
};

exports.updateComment = async (req, res) => {
  const params = {
    issue_id: req.params.issue_id,
    comment_id: req.params.comment_id,
    content: req.body.content,
    user: req.user
  }
  const { status, data } = await issueService.updateComment(params);
  res.status(status).json(data);
};

exports.deleteComment = async (req, res) => {
  const params = {
    issue_id: req.params.issue_id,
    comment_id: req.params.comment_id
  }
  const { status, data } = await issueService.deleteComment(params);
  res.status(status).json(data);
};
