const { Milestone } = require('../models');

exports.getAll = async (req, res) => {
  try {
    const result = await Milestone.findAll({ attributes: ['id', 'title', 'due_date'] });
    return { status: 200, data: result };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 요청 입니다.' } };
  }
};
