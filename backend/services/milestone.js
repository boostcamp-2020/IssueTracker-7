const { Milestone } = require('../models');

exports.getAll = async () => {
  try {
    const result = await Milestone.findAll({
      attributes: ['id', 'title', 'due_date', 'description'],
    });
    return { status: 200, data: result };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 요청 입니다.' } };
  }
};

exports.create = async ({ title, due_date, description }) => {
  try {
    const milestone = await Milestone.findOrCreate({
      where: {
        title,
      },
      defaults: {
        due_date,
        description,
      },
    });
    if (milestone[1]) {
      return { status: 200, data: milestone[0] };
    } else {
      return { status: 401, data: { message: '제목이 중복되는 milestone이 있습니다.' } };
    }
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력 입니다.' } };
  }
};

exports.update = async ({ milestone_id }, { title, due_date, description }) => {
  try {
    const milestone = await Milestone.findByPk(milestone_id, {
      attributes: ['id', 'title', 'due_date', 'description'],
    });
    if (milestone) {
      if (title) milestone.title = title;
      if (due_date) milestone.due_date = due_date;
      if (description) milestone.description = description;
      const updatedMilestone = await milestone.save();
      return { status: 200, data: updatedMilestone };
    } else {
      return { status: 401, data: { message: '유효하지 않은 milestone 입니다.' } };
    }
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력 입니다.' } };
  }
};
exports.delete = async ({ milestone_id }) => {
  const result = await Milestone.destroy({
    where: {
      id: milestone_id,
    },
  });
  if (result) {
    return { status: 200, data: { message: '삭제 되었습니다.' } };
  } else {
    return { status: 401, data: { message: '유효하지 않은 milestone 입니다.' } };
  }
};
