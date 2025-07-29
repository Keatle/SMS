const express = require('express');
const router = express.Router();
const agendaController = require('../Controller/agenda.controller');

// Route to get agendas based on user ID
//router.get('/:userID', agendaController.getAgendas);
router.get('/getBSN/:studentN', agendaController.getAgendas);


module.exports = router;

