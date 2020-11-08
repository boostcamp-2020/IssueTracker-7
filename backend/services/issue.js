const { Issue, Label, User, Comment, label_has_issue, Milestone } = require('../models');
const Op = require('sequelize').Op;
const optionParser = (queryString) => queryString.match(/(\w+)([@/-\w가-힇]+)|(".*?")+(?=\:?)/gi);
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
          user_id: assignee == '@me' ? user_id : author,
        }
      : null,
    attributes: ['id', 'user_id', 'photo_url', 'type'],
  };
};
const getMentionsFilter = ({ mentions, user_id }) => {
  return {
    model: Comment,
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
    else return { status: 401, data: { message: '유효하지 않은 Label 입니다.' } };
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
    
exports.create = async ({ title, milestone_id, author_id }) => {
  try {
    const result = await Issue.findOrCreate({
      where: { title },
      defaults: { milestone_id: milestone_id, user_id: author_id },
    });
    if (result[1]) {
      return { status: 200, data: result[0] };
    } else return { status: 401, data: { message: '제목이 중복되는 이슈가 있습니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력 입니다.' } };
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
  };
};

exports.deleteLabel = async (issue_id, label_id) => {
  try {
    const result = await label_has_issue.destroy({
      where: { issue_id: issue_id, label_id: label_id }})
    console.log(result)
    if (result) return { status: 200, data: result };
    else return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
  };
};