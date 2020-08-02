import * as functions from 'firebase-functions';

const isDev = process.env.DEV;

const env = isDev ? require('../../../env.json') : functions.config();

const mysql = require('promise-mysql');
const mysqlRaw = require('mysql');
const toUnnamed = require('named-placeholders')();

let pool;
export default {
  initialize: async function() {
    try {
      pool = await mysql.createPool({
        user: env.mysql.user,
        password: env.mysql.password,
        database: env.mysql.database,
        ...!env.mysql.socketpath && {
          host: env.mysql.host,
          port: env.mysql.port
        },
        ...env.mysql.socketpath && {
          socketPath: env.mysql.socketpath
        }
      });
      return pool;
    } catch (err) {
      //console.log(err);
    }
  },

  getPool: function() {
    return pool;
  },

  //idempotent
  executeDBQuery: async (query, params) => {
    try {
      const q = toUnnamed(query, params);

      if(isDev) {
        console.log(query);
        console.log(params);
      }

      const connection = await pool.getConnection();
      const results = await connection.query(q[0], q[1]);
      connection.release();

      return results;
    } catch(err) {
			throw err;
    }
  },

  getMysqlRaw(rawStatement) {
    return mysqlRaw.raw(rawStatement);
  }
};