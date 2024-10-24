const jsonServer = require('json-server');
const server = jsonServer.create();
const router = jsonServer.router('db.json'); 
const middlewares = jsonServer.defaults();

server.use(middlewares);
server.use(router);

const port = 3500;  
server.listen(port, () => {
  console.log(`JSON Server is running on http://localhost:${port}`);
});
