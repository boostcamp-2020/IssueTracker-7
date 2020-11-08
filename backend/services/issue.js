const { Issue } = require('../models');

exports.create = async ({ title, mileston_id, author_id }) => {
  try {
    const result = await Issue.findOrCreate({
      where: { title },
      defaults: { mileston_id, author_id },
    });
    if (result[1]) {
      return { status: 200, data: result[0] };
    } else return { status: 401, data: { message: '제목이 중복되는 이슈가 있습니다.' } };
  } catch (err) {
    return { status: 401, data: { message: '유효하지 않은 입력 입니다.' } };
  }
};
