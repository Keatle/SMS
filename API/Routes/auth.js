const express = require('express');
const router = express.Router();
const authController = require('../Controller/auth.controller');

// Change password route
router.put('/cPass', authController.changePassword);

module.exports = router;
