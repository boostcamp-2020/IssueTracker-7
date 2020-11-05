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

exports.create = async (label) => {
    let result;
    try {
        result = await Label.create(label);
    } catch (err) {
        return false;
    }
    return result;
}