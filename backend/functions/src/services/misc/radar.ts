import axios from 'axios'

import errorHelper from '../../helpers/tier0/error';

const radarApi = axios.create({
  baseURL: "https://api.radar.io/v1",
  headers: {
    Authorization: "prj_test_sk_24bb5d5d024a5567fc752157b1e22636071fa038"
  }
});

export class Radar {
  static doAction() {
    return radarApi.get("/search/places?categories=food-beverage&near=40.78382,-73.97779");
  }

  static async getNearbyPlaces(categories: Array<string>, latitude: Number, longitude: Number) {
    if(!categories.length) {
      throw errorHelper.missingParamsError();
    }

    const { data } = await radarApi.get("/search/places?categories=" + categories.join(",") + "&near=" + latitude + "," + longitude);

    return data.places;
  }

  static async getPlace(placeId) {
    if(!placeId) {
      throw errorHelper.missingParamsError();
    }

    const { data } = await radarApi.get("/places/" + placeId);

    return data.place;
  }


  static async getGeofence(geofenceId) {
    if(!geofenceId) {
      throw errorHelper.missingParamsError();
    }

    const { data } = await radarApi.get("/geofences/" + geofenceId);

    return data.place;
  }

  static async createGeofence(description: string, latitude: Number, longitude: Number) {
    const { data } = await radarApi.post("/geofences", {
      description: description,
      coordinates: [latitude, longitude],
      radius: 50,
      type: "circle"
    });

    return data.geofence;
  }

  //static async createGeoFence() {
  //
  //}
};