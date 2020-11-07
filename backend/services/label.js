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
    const { name, description, color } = newLabel;
    try {
        const result = await Label.findOrCreate({
            where: { name: name },
            defaults: { description: description, color: color }
        });
        return result[1];
    } catch (err) {
        return false;
    }
}