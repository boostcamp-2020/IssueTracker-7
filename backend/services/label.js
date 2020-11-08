const { Label, label_has_issue } = require('../models');

exports.getAll = async (issue) => {
    let result;
    try {
        if (issue) {
            result = await Label.findAll({
                attributes: ['id', 'name', 'description', 'color'],
                include: [
                    {
                        model: label_has_issue,
                        where: {
                            issue_id: issue
                        },
                        attributes: ['label_id']
                    }
                ]
            });
        } else {
            result = await Label.findAll({
                attributes: ['id', 'name', 'description', 'color']
            });
        };
    } catch (err) {
        return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
    };
    if (result) return { status: 200, data: result };
    else return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
};


exports.getOne = async ({ label_id }) => {
  try {
    const label = await Label.findByPk(label_id, {
      attributes: ['id', 'name', 'color', 'description'],
    });
    if (label) {
      return { status: 200, data: label };
    } else {
      return { status: 401, data: '유효하지 않은 레이블 입니다.' };
    }
  } catch (err) {
    return { status: 401, data: '유효하지 않은 입력 입니다.' };
  }
};

exports.create = async (newLabel) => {
  const { name, description, color } = newLabel;
  try {
    const result = await Label.findOrCreate({
      where: { name: name },
      defaults: { description: description, color: color },
    });
    if (result[1]) return { status: 200, data: result[0] };
    else return { status: 401, data: { message: '이미 레이블이 존재합니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
  }
};

exports.delete = async ({ label_id }) => {
  try {
    const result = await Label.destroy({
      where: {
        id: label_id,
      },
    });
    if (result) {
      return { status: 200, data: { message: '삭제 되었습니다.' } };
    } else {
      return { status: 401, data: { message: '유효하지 않은 레이블 입니다.' } };
    }
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력 입니다.' } };
  }
};

exports.update = async ({ label_id }, { name, description, color }) => {
  try {
    const label = await Label.findByPk(label_id, {
      attributes: ['id', 'name', 'description', 'color'],
    });
    if (label) {
      if (name) label.name = name;
      if (description) label.description = description;
      if (color) label.color = color;
      const updatedLabel = await label.save();
      return { status: 200, data: updatedLabel };
    } else {
      return { status: 401, data: { message: '유효하지 않은 레이블 입니다.' } };
    }
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력입니다.' } };
  }
};
