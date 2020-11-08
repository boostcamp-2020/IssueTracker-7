const express = require('express');
const router = express.Router();
const milestoneController = require('../../controllers/milestone');

router.get('/', milestoneController.getAll);
router.post('/', milestoneController.add);
router.put('/:milestone_id', milestoneController.update);
router.delete('/:milestone_id', milestoneController.delete);

module.exports = router;
