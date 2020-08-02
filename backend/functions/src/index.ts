import * as functions from 'firebase-functions';
import * as express from 'express';
import * as admin from 'firebase-admin';
admin.initializeApp();

//utils
import mysql from './utils/mysql';

import * as jql from "./jql";
import * as schema from "./schema";
import { handleWebhook, handlePusherAuth } from "./helpers/tier3/subscription";

import { handleRadarWebhook } from "./helpers/tier3/radar";

mysql.initialize();

const app = express();

//extract the user ID from all requests.
app.use(async function(req, res, next) {
  //we're just gonna assign a bogus user for now
  req["user"] = {
    id: 1
  };
  next();
});

jql.process(app, schema);

app.post('/pusher/auth', handlePusherAuth);

app.post('/pusher/webhook', handleWebhook);

app.post('/radar/webhook', handleRadarWebhook);

export const api = functions.https.onRequest(app);