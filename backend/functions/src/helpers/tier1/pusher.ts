import * as Pusher from "pusher";

export const pusher = new Pusher({
  appId: 'APP_ID',
  key: 'KEY',
  secret: 'SECRET',
  cluster: 'CLUSTER',
  useTLS: true
});