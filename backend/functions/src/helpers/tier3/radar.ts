import mysqlHelper from '../tier1/mysql';

export async function handleRadarWebhook(req, res) {
  if(req.body.type === "user.entered_geofence") {
    //update the bingoTile with that geofence id
    await mysqlHelper.executeDBQuery("UPDATE bingoTile SET isCompleted = 1 WHERE geofence = :geofence", {
      geofence: req.body.geofence._id
    });
  }
  res.send({});
}