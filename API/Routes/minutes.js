const express = require('express');
const router = express.Router();
const minutesController = require('../Controller/minutes.controller');

// Get minutes by student number
router.get('/getBSN/:studentN', minutesController.getMinutesBSN);

// Get all minutes
router.get('/', minutesController.getMinutes);

// Get a single minute by ID
router.get('/:minutesID', minutesController.getMinuteById);

module.exports = router;
