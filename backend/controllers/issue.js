const { Issue, Label, Comment, User, Milestone, label_has_issue } = require('../models');
const queryParser = (queryString) => queryString.match(/(\w+)([@/-\w가-힇]+)|(".*?")+(?=\:?)/gi);
const queryToObject = (queryString) => {
  const queryArray = queryParser(queryString);
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

exports.get = async (req, res) => {
  const query = queryToObject(req.query.q ? req.query.q : '');
  const where = {};
  const include = [
    {
      model: Label,
      as: 'labels',
      right: query.no.includes('label') ? false : query.label ? true : false,
      through: {
        attributes: [],
      },
      attributes: ['id', 'name', 'description', 'color'],
      include: {
        model: label_has_issue,
        required: query.no.includes('label') ? true : query.label ? false : true,
        include: [
          {
            model: Label,
            where: query.label
              ? {
                  name: query.label,
                }
              : null,
          },
        ],
        attributes: [],
      },
    },
    {
      model: User,
      as: 'assignees',
      where: query.assignee
        ? {
            user_id: query.assignee == '@me' ? req.user.user_id : query.assignee,
          }
        : null,
      attributes: ['id', 'user_id', 'photo_url', 'type'],
      through: {
        attributes: [],
      },
    },
    {
      model: User,
      as: 'author',
      where: query.author
        ? {
            user_id: query.assignee == '@me' ? req.user.user_id : query.author,
          }
        : null,
      attributes: ['id', 'user_id', 'photo_url', 'type'],
    },
    {
      model: Comment,
      include: {
        model: User,
        as: 'mentions',
        where:
          query.mentions == '@me'
            ? {
                user_id: query.mentions,
              }
            : null,
      },
    },
    {
      model: Milestone,
      where: query.milestone
        ? {
            title: query.milestone,
          }
        : null,
      attributes: ['id', 'title', 'due_date'],
    },
  ];

  query.is.forEach((value) => {
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
  if (query.no.includes('author')) where.user_id = null;
  if (query.no.includes('milestone')) where.milestone_id = null;
  Issue.findAll({
    where,
    include,
  })
    .then((issues) => {
      let queryResult = issues;
      if (query.no.includes('assignee')) {
        queryResult = queryResult.filter((isssue) => isssue.assignees.length == 0);
      }
      if (query.no.includes('label')) {
        queryResult = queryResult.filter((isssue) => isssue.labels.length == 0);
      }
      res.status(200).json(queryResult);
    })
    .catch((err) => {
      console.log(err);
    });
};
