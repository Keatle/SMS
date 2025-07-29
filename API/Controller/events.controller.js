const eventService = require('../Services/event.service');

// GET: Retrieve events by student number
exports.getEventsBySN = async (req, res, next) => {
    try {
        const { studentN } = req.params;
        console.log('Received request for events by student number:', studentN);
        const events = await eventService.getEventsBySN(studentN);
        console.log('Events retrieved:', events);
        res.json(events);
    } catch (err) {
        console.error('Error in getEventsBySN controller:', err);
        next(err);
    }
};

// READ: Retrieve all events
exports.getEvents = async (req, res, next) => {
    try {
        const events = await eventService.getEvents();
        res.json(events);
    } catch (err) {
        next(err);
    }
};

// READ: Retrieve events by user ID (societies a student is part of)
exports.getEventsByStudent = async (req, res, next) => {
    try {
        const { userID } = req.params;
        const events = await eventService.getEventsByStudent(userID);
        res.json(events);
    } catch (err) {
        next(err);
    }
};

// READ: Retrieve a single event by ID
exports.getEventById = async (req, res, next) => {
    try {
        const { eventID } = req.params;
        const event = await eventService.getEventById(eventID);
        res.json({ nextStatus: true, event });
    } catch (err) {
        next(err);
    }
};
