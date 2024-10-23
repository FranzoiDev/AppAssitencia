const fs = require('fs');
const path = require('path');
const jsonServer = require('json-server');
const cors = require('cors');
const server = jsonServer.create();
const router = jsonServer.router('db.json');
const middlewares = jsonServer.defaults();

server.use(cors());
server.use(middlewares);
server.use(router);

const port = process.env.PORT || 0;

const httpServer = server.listen(port, () => {
  const address = httpServer.address();
  const portInUse = address.port;        

  const portFilePath = path.join(__dirname, 'port.json');
  fs.writeFileSync(portFilePath, JSON.stringify({ port: portInUse }), 'utf8');

  console.log(`JSON Server is running on port ${portInUse}`);
});

server.get('/getPort', (req, res) => {
  const portInUse = httpServer.address().port;
  res.json({ port: portInUse });
});
