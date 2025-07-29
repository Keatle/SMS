const express = require('express');
const router = express.Router();

const eventsController = require('../Controller/events.controller');

// Get events by student number
router.get('/getBSN/:studentN', eventsController.getEventsBySN);

// Get all events
router.get('/', eventsController.getEvents);

// Get events by student ID (societies a student is part of)
router.get('/student/:userID', eventsController.getEventsByStudent);

// Get a single event by ID
router.get('/:eventID', eventsController.getEventById);

module.exports = router;

