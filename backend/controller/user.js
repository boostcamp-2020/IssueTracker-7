const { User } = require('../models')

exports.get = async (req, res) => {
    const users = await User.findAll({
        attributes: ['id', 'user_id', 'photo_url', 'type']
    })
    res.json(users)
}