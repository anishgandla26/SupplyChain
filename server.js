const next = require('next')
const routes = require('./routes')
const app = next({dev: process.env.NODE_ENV !== 'production'})
const handler = routes.getRequestHandler(app)

const {createServer} = require('http')
const { isBuffer } = require('util')
app.prepare().then(() => {
  createServer(handler).listen(3000, (err) => {
      if(err) throw err;
      console.log('Ready on localhost : 3000');
  });
})