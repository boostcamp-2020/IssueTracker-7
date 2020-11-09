const express = require('express');
const router = express.Router();
const issueController = require('../../controllers/issue');

router.get('/', issueController.getAll);
router.post('/', issueController.add);
router.get('/:issue_id', issueController.getOne);
router.put('/:issue_id', issueController.update);

router.get('/:issue_id/milestone', issueController.getMilestone);
router.post('/:issue_id/milestone/:milestone_id', issueController.addMilestone);
router.delete('/:issue_id/milestone', issueController.deleteMilestone);

router.get('/:issue_id/label', issueController.getLabel);
router.post('/:issue_id/label', issueController.addLabel);
router.delete('/:issue_id/label/:label_id', issueController.deleteLabel);

router.get('/:issue_id/assignee', issueController.getAssigneeAll);
router.get('/:issue_id/assignee/:assignee_id', issueController.getAssigneeOne);
router.post('/:issue_id/assignee', issueController.addAssignee);
router.delete('/:issue_id/assignee/:assignee_id', issueController.deleteAssignee);

module.exports = router;