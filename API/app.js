const express = require('express');
const cors = require('cors');
const bparser = require('body-parser');
const app = express();
app.use(bparser.json());


//const userRoute = require('./Routes/user'); // Renamed to avoid confusion
const eventAttendanceRoute = require('./Routes/eventattendance');
const changePasswordRoute = require('./Routes/auth'); // Added Route name
const meetingsRoute = require('./Routes/agenda');
const eventsRoute = require('./Routes/event'); // Adjust path as needed
const minutesRoutes = require('./Routes/minutes');

app.use('/minutes', minutesRoutes);
//app.use('/', userRoute);
app.use('/events', eventsRoute); //runs as middleware
app.use('/eventattendance', eventAttendanceRoute);
app.use('/agenda', meetingsRoute);
app.use('/changePassword', changePasswordRoute);

module.exports = app;

