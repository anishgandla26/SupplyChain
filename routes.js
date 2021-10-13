const routes = require('next-routes')();
routes
    .add('/hello/show','/show')
    .add('/supply-chain/new','/supply_chian/new');
module.exports = routes;