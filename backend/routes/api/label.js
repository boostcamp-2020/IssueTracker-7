const express = require('express');
const router = express.Router();
const labelController = require('../../controllers/label');

router.get('/', labelController.getAll);
router.get('/:label_id', labelController.getOne);
router.post('/', labelController.add);
router.delete('/:label_id', labelController.delete);
router.put('/:label_id', labelController.update);

module.exports = router;
