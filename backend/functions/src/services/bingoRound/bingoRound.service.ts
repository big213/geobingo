import Service from '../service';
import generatePaginatorService from '../generator/paginator.service';

import errorHelper from '../../helpers/tier0/error';
import resolverHelper from '../../helpers/tier2/resolver';

import { handleJqlSubscriptionTriggerIterative } from '../../helpers/tier3/subscription'

import { BingoTile } from '../services';

import { Radar } from '../misc/radar';

export class BingoRound extends Service {
  static __typename = 'bingoRound';
  static paginator = generatePaginatorService(BingoRound);
  
  static presets = {
    default: {
      id: null,
      name: null,
      created_by: {
        id: null,
        name: null
      }
    }
  };

  static filterFieldsMap = {
    id: {
      field: "id",
    },
    created_by: {
      field: "created_by",
    },
    "created_by.name": {
      field: "created_by",
      foreignField: "name"
    }
  };

  static isFilterRequired = false;

  static searchableFields = ["name"];

  static sortFields = ["id", "created_by"];
  
  static accessControl = {
    get: () => true,
    getMultiple: () => true,
    add: () => true,
    update: () => true,
    delete: () => true,
  };

  static async addRecord(req, args = <any> {}, query?: object) {
    if(!req.user) throw errorHelper.loginRequiredError();

    //if it does not pass the access control, throw an error
    if(!await this.testPermissions('add', req, args, query)) {
      throw errorHelper.badPermissionsError();
    }

    //size required
    const length = parseInt(args.length);

    if(!length || length < 0) {
      throw errorHelper.missingParamsError();
    }

    //lat+long required
    if(!args.latitude || !args.longitude) {
      throw errorHelper.missingParamsError();
    }

    //fetch 10 places nearby the lat/long
    const nearbyPlaces = await Radar.getNearbyPlaces(["food-beverage", "shopping-retail", "arts-entertainment"], args.latitude, args.longitude);

    if(nearbyPlaces.length <= length) {
      throw errorHelper.generateError("Not enough places nearby to create a bingo board of this size");
    }

    const addResults = await resolverHelper.addTableRow(this.__typename, {
      ...args,
      created_by: req.user.id
    });
    
    //select some random places
    const placesSet = new Set();

    while(placesSet.size < length) {
      placesSet.add(nearbyPlaces[Math.floor(Math.random()*nearbyPlaces.length)])
    }

    const placesArray = <any> [...placesSet];

    //add the bingoTiles
    for(let i=0; i<length; i++) {
      //create a geofence for each nearbyPlace
      const geofence = await Radar.createGeofence(placesArray[i].name, placesArray[i].location.coordinates[0], placesArray[i].location.coordinates[1]);
      await resolverHelper.addTableRow(BingoTile.__typename, {
        position: i+1,
        place: placesArray[i]._id,
        place_name: placesArray[i].name,
        geofence: geofence._id,
        isCompleted: false,
        bingoRound: addResults.id
      });
    }

    const validatedArgs = {
      created_by: req.user.id
    };

    handleJqlSubscriptionTriggerIterative(req, this, this.__typename + 'Added', validatedArgs, { id: addResults.id });

    return this.getRecord(req, { id: addResults.id }, query);
  }

};