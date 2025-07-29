const express = require('express');
const router = express.Router();
const attendanceController = require('../Controller/eventattendance.controller');

router.post('/verify', attendanceController.verifyAttendanceCode);
router.post('/record', attendanceController.recordAttendance);

module.exports = router;