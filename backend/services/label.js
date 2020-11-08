const { Label } = require('../models');

exports.getAll = async () => {
    let result;
    try {
        result = await Label.findAll({ attributes: ['id', 'name', 'description', 'color'] });
    } catch (err) {
        return false;
    }
    return result;

}
exports.findByName = async (label) => {
    let result;
    try {
        result = await Label.findOne({ where: { name: label.name } });
    } catch (err) {
        return false;
    }
    return result;
}

exports.create = async (newLabel) => {
    const { name, description, color } = newLabel;
    try {
        const result = await Label.findOrCreate({
            where: { name: name },
            defaults: { description: description, color: color }
        });
        if (result[1]) return { status: 200, data: result[0] };
        else return { status: 401, data: { message: '이미 레이블이 존재합니다.' } };
    } catch (err) {
        return { status: 401, data: { message: '유효하지 않은 입력입니다.'}};
    }
}