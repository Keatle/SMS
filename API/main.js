const express = require('express');
const cors = require('cors');
const app = express();
const eventsRoute = require('./Routes/event'); 

app.use('/api/events', eventsRoute); 

app.listen(33, () => {
  console.log('Server is running on http://localhost:33');
});
