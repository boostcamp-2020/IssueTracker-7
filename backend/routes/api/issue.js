var express = require('express');
var router = express.Router();
const issueController = require('../../controllers/issue');

router.get('/', issueController.getAll);
router.post('/', issueController.add);
router.get('/:issue_id', issueController.getOne);
router.put('/:issue_id', issueController.update);

router.get('/:issue_id/milestone', issueController.getMilestone);
router.post('/:issue_id/milestone/:milestone_id', issueController.addMilestone);
router.delete('/:issue_id/milestone', issueController.deleteMilestone);

module.exports = router;
