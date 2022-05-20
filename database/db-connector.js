var mysql = require('mysql')

var pool = mysql.createPool({
    connectionLimit : 10,
    host            : 'classmysql.engr.oregonstate.edu',
    user            : 'cs340_kesserm',
    password        : '9265',
    database        : 'cs340_kesserm'
})

module.exports.pool = pool;