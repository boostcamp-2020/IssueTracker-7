const { User } = require('../models');

exports.getAll = async () => {
    try {
      const result = await User.findAll({
          attributes: ['id', 'user_name', 'photo_url']
      });
      if (result) return { status: 200, data: result };
    else return { status: 401, data: { message: '유효하지 않은 접근입니다.' } };
    } catch (err) {
        return { status: 401, data: { message: '유효하지 않은 접근입니다.' } };
    };
};
  