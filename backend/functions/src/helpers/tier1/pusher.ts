import * as Pusher from "pusher";

export const pusher = new Pusher({
  appId: '1043478',
  key: 'bd374c7a1ce63b08aa94',
  secret: '8e4c1a6887151d514415',
  cluster: 'us2',
  useTLS: true
});