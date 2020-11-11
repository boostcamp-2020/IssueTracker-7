const { Issue, Label, User, Comment, label_has_issue, Milestone, sequelize } = require('../models');
const Op = require('sequelize').Op;
const optionParser = (queryString) => queryString.match(/(\w+|@)([@/-\w가-힇]+)|(".*?")+(?=\:?)/gi);
const optionStringToObject = (queryString) => {
  const queryArray = optionParser(queryString);
  const queryObject = { is: [], no: [] };
  if (queryArray) {
    for (let i = 0; i < queryArray.length; i += 2) {
      if (queryArray[i] === 'is') {
        queryObject.is.push(queryArray[i + 1]);
      } else if (queryArray[i] === 'no') {
        queryObject.no.push(queryArray[i + 1]);
      } else {
        let value = queryArray[i + 1];
        if (value[0] == `"`) {
          value = value.replace(/\"/gi, '');
          value = value.replace(/\+/gi, ' ');
        }
        queryObject[queryArray[i]] = value;
      }
    }
  }
  return queryObject;
};
const getLabelFilter = async ({ label, no, user_id }) => {
  return {
    model: Label,
    as: 'labels',
    right: no.includes('label') ? false : label ? true : false,
    through: {
      attributes: [],
      where: label
        ? {
            issue_id: {
              [Op.in]: await this.hasLabelName(label),
            },
          }
        : null,
    },
    attributes: ['id', 'name', 'description', 'color'],
  };
};
const getAssigneesFilter = ({ assignee, no, user_id }) => {
  return {
    model: User,
    as: 'assignees',
    where: assignee
      ? {
          user_id: assignee == '@me' ? user_id : assignee,
        }
      : null,
    attributes: ['id', 'user_id', 'photo_url', 'type'],
    through: {
      attributes: [],
    },
  };
};
const getAuthorFilter = ({ author, no, user_id }) => {
  return {
    model: User,
    as: 'author',
    where: author
      ? {
          user_id: author == '@me' ? user_id : author,
        }
      : null,
    attributes: ['id', 'user_id', 'photo_url', 'type'],
  };
};
const getMentionsFilter = ({ mentions, user_id }) => {
  return {
    model: Comment,
    required: mentions ? true : false,
    include: {
      model: User,
      as: 'mentions',
      where: mentions
        ? {
            user_id: mentions == '@me' ? user_id : mentions,
          }
        : null,
    },
  };
};
const getMilestoneFilter = ({ milestone }) => {
  return {
    model: Milestone,
    where: milestone
      ? {
          title: milestone,
        }
      : null,
    attributes: ['id', 'title', 'due_date'],
  };
};
const getWhereFilter = ({ is, no }) => {
  const where = {};
  is.forEach((value) => {
    switch (value) {
      case 'issue':
        break;
      case 'open':
        where.status = 'open';
        break;
      case 'closed':
        where.status = 'closed';
        break;
    }
  });
  if (no.includes('author')) where.user_id = null;
  if (no.includes('milestone')) where.milestone_id = null;
  return where;
};

exports.hasLabelName = async (name) => {
  return (
    await label_has_issue.findAll({
      attributes: ['issue_id'],
      include: [
        {
          model: Label,
          where: {
            name,
          },
          attributes: [],
        },
      ],
    })
  ).map((issue) => issue.issue_id);
};

exports.getFilteredAll = async (params, user_id) => {
  try {
    const options = optionStringToObject(params.q ? params.q : '');
    options.user_id = user_id;
    const where = getWhereFilter(options);
    const include = [
      await getLabelFilter(options),
      getAssigneesFilter(options),
      getAuthorFilter(options),
      getMentionsFilter(options),
      getMilestoneFilter(options),
    ];
    let issues = await Issue.findAll({
      where,
      include,
    });
    if (options.no.includes('assignee')) {
      issues = issues.filter((isssue) => isssue.assignees.length == 0);
    }
    if (options.no.includes('label')) {
      issues = issues.filter((isssue) => isssue.labels.length == 0);
    }
    return { status: 200, data: issues };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 요청 입니다.' } };
  }
};

exports.getOne = async ({ issue_id }) => {
  try {
    const issue = await Issue.findByPk(issue_id, {
      attributes: ['id', 'title', 'status', 'created_at', 'updated_at'],
      include: [
        {
          model: User,
          as: 'author',
          attributes: ['id', 'user_id', 'photo_url', 'type'],
        },
      ],
    });
    if (issue) return { status: 200, data: issue };
    else return { status: 401, data: { message: '유효하지 않은 Issue 입니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 요청 입니다.' } };
  }
};

exports.update = async ({ issue_id }, { title, status }) => {
  try {
    const issue = await Issue.findByPk(issue_id);
    if (issue) {
      if (title) issue.title = title;
      if (status) issue.status = status;
      const updatedIssue = await issue.save();
      return { status: 200, data: updatedIssue };
    } else {
      return { status: 401, data: { message: '유효하지 않은 Label 입니다.' } };
    }
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력 입니다.' } };
  }
};

exports.create = async ({
  title,
  milestone_id,
  label_id_list,
  assignee_id_list,
  author_id,
  content,
}) => {
  const t = await sequelize.transaction();
  try {
    const label_ids = label_id_list ? JSON.parse(label_id_list) : [];
    const assignee_ids = assignee_id_list ? JSON.parse(assignee_id_list) : [];
    const result = await Issue.findOrCreate({
      where: { title },
      defaults: { milestone_id: milestone_id, user_id: author_id },
      transaction: t,
    });
    if (result[1]) {
      const newIssue = result[0];
      await newIssue.addLabels(label_ids, { transaction: t });
      await newIssue.addAssignee(assignee_ids, { transaction: t });
      await Comment.create(
        { user_id: author_id, content, issue_id: newIssue.id },
        { transaction: t }
      );
      await t.commit();
      return await this.getOne({ issue_id: newIssue.id });
    } else return { status: 401, data: { message: '제목이 중복되는 이슈가 있습니다.' } };
  } catch (err) {
    await t.rollback();
    return { status: 401, data: { message: '유효하지 않은 입력 입니다.' } };
  }
};

exports.getLabel = async (issue_id) => {
  let result;
  try {
    const issue = await Issue.findByPk(issue_id);
    result = await issue.getLabels();
    if (result) return { status: 200, data: result };
    else return { status: 401, data: { message: '유효하지 않은 이슈입니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
  }
};

exports.addLabel = async (issue_id, label_id) => {
  try {
    const issue = await Issue.findByPk(issue_id);
    const label = await Label.findByPk(label_id);
    const result = await issue.addLabel(label);

    if (result) return { status: 200, data: result[0] };
    else return { status: 401, data: { message: '이미 존재하는 레이블입니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
  }
};

exports.deleteLabel = async (issue_id, label_id) => {
  try {
    const result = await label_has_issue.destroy({
      where: { issue_id: issue_id, label_id: label_id },
    });
    if (result) return { status: 200, data: { message: 'success' } };
    else return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
  }
};

exports.getAssigneeAll = async (issue_id) => {
  try {
    const issue = await Issue.findByPk(issue_id);
    const result = await issue.getAssignees({
      attributes: ['id', 'user_id', 'photo_url'],
    });
    if (result) return { status: 200, data: result };
    else return { status: 401, data: { message: '유효하지 않은 이슈입니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 접근입니다.' } };
  }
};

exports.getAssigneeOne = async (issue_id, assignee_id) => {
  try {
    const issue = await Issue.findByPk(issue_id);
    const result = await issue.getAssignees({
      where: { id: assignee_id },
      attributes: ['id', 'user_id', 'photo_url'],
    });
    if (result) return { status: 200, data: result[0] };
    else return { status: 401, data: { message: '유효하지 않은 사용자입니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 접근입니다.' } };
  }
};

exports.addAssignee = async (issue_id, user_id) => {
  try {
    const issue = await Issue.findByPk(issue_id);
    const user = await User.findByPk(user_id);
    const assignee = await issue.addAssignee(user);
    const result = await issue.getAssignees({
      where: { id: user_id },
      attributes: ['id', 'user_id', 'photo_url'],
    });
    if (result) return { status: 200, data: result[0] };
    else return { status: 401, data: { message: '이미 승인한 사용자입니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 접근입니다.' } };
  }
};

exports.deleteAssignee = async (issue_id, user_id) => {
  try {
    const issue = await Issue.findByPk(issue_id);
    const user = await User.findByPk(user_id);
    const result = await issue.removeAssignee(user);
    if (result) return { status: 200, data: { message: 'success' } };
    else return { status: 401, data: { message: '존재하지 않는 Assignee입니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
  }
};

exports.getMilestone = async ({ issue_id }) => {
  try {
    const issue = await Issue.findByPk(issue_id);
    if (issue) {
      const milestone = await issue.getMilestone({
        attributes: ['id', 'title', 'due_date', 'description'],
        include: [
          {
            model: Issue,
            attributes: ['id', 'title', 'status'],
          },
        ],
      });
      return { status: 200, data: milestone };
    } else {
      return { status: 401, data: { message: '유효하지 않은 Issue 입니다.' } };
    }
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
  }
};

exports.addMilestone = async ({ issue_id, milestone_id }) => {
  try {
    const issue = await Issue.findByPk(issue_id);
    if (issue) {
      issue.milestone_id = milestone_id;
      await issue.save();
      return { status: 200, data: { message: 'success' } };
    } else {
      return { status: 401, data: { message: '유효하지 않은 issue 입니다.' } };
    }
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
  }
};

exports.deleteMilestone = async ({ issue_id }) => {
  try {
    const issue = await Issue.findByPk(issue_id);
    if (issue) {
      issue.milestone_id = null;
      await issue.save();
      return { status: 200, data: { message: 'success' } };
    } else {
      return { status: 401, data: { message: '유효하지 않은 issue 입니다.' } };
    }
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
  }
};

exports.getCommentAll = async (issue_id) => {
  try {
    const result = await Comment.findAll({
      where: { issue_id: issue_id },
      attributes: ['id', 'content', 'updated_at'],
      include: [
        {
          model: User,
          as: 'mentions',
          attributes: ['id', 'user_id', 'photo_url'],
        },
      ],
    });
    if (result) return { status: 200, data: result };
    else return { status: 401, data: { message: '유효하지 않은 이슈입니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 접근입니다.' } };
  }
};

exports.getCommentOne = async ({ issue_id, comment_id }) => {
  try {
    const result = await Comment.findOne({
      where: { id: comment_id, issue_id: issue_id },
      attributes: ['id', 'content', 'updated_at'],
      include: [
        {
          model: User,
          as: 'mentions',
          attributes: ['id', 'user_id', 'photo_url'],
        },
      ],
    });
    if (result) return { status: 200, data: result };
    else return { status: 401, data: { message: '유효하지 않은 코멘트입니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 접근입니다.' } };
  }
};

exports.addComment = async ({ issue_id, content, user }) => {
  try {
    const newComment = await Comment.create({
      content: content,
      user_id: user.id,
      issue_id: issue_id,
    });
    const result = await Comment.findOne({
      where: newComment.dataValues,
      attributes: ['id', 'content', 'updated_at'],
      include: [
        {
          model: User,
          as: 'mentions',
          attributes: ['id', 'user_id', 'photo_url'],
        },
      ],
    });
    if (result) return { status: 200, data: result };
    else return { status: 401, data: { message: '잘못된 접근입니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 접근입니다.' } };
  }
};

exports.updateComment = async ({ issue_id, comment_id, content, user }) => {
  try {
    const comment = await Comment.update(
      { content: content },
      {
        where: { id: comment_id, issue_id: issue_id, user_id: user.id },
      }
    );
    const result = await Comment.findOne({
      where: comment.dataValues,
      attributes: ['id', 'content', 'updated_at'],
      include: [
        {
          model: User,
          as: 'mentions',
          attributes: ['id', 'user_id', 'photo_url'],
        },
      ],
    });
    if (result) return { status: 200, data: result };
    else return { status: 401, data: { message: '잘못된 접근입니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 접근입니다.' } };
  }
};

exports.deleteComment = async ({ issue_id, comment_id }) => {
  try {
    const result = await Comment.destroy({
      where: { id: comment_id },
    });
    if (result) return { status: 200, message: 'success' };
    else return { status: 401, data: { message: '잘못된 접근입니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
  }
};
