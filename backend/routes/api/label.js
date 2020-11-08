const express = require('express');
const router = express.Router();
const labelController = require('../../controllers/label');

router.get('/', labelController.get);
router.get('/:label_id', labelController.getOne);
router.post('/', labelController.add);

module.exports = router;
