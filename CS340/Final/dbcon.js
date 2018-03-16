var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_wongnich',
  password        : 'acta3eHt6r7K8YNd',
  database        : 'cs340_wongnich'
});
module.exports.pool = pool;
