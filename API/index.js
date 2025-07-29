const app= require('./app');
const port = 33;
app.listen(port, ()=>{
console.log('Server is running on http://localhost:%d', port);
});