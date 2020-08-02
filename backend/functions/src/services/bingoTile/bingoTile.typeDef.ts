import { Radar } from '../misc/radar';

export default {
  id: {
    mysqlOptions: {
      filterable: true
    }
  },
  position: {
    mysqlOptions: {
      addable: true
    }
  },
  place_name: {
    mysqlOptions: {
      addable: true
    }
  },
  place: {
    mysqlOptions: {
      addable: true
    },
    resolver: async (context, req, currentObject, query, args) => {
      return Radar.getPlace(currentObject.place).catch(() => null);
    }
  },
  geofence: {
    mysqlOptions: {
      addable: true
    },
    resolver: async (context, req, currentObject, query, args) => {
      return Radar.getGeofence(currentObject.geofence).catch(() => null);
    }
  },
  isCompleted: {
    mysqlOptions: {
      addable: true
    }
  },
  bingoRound: {
    mysqlOptions: {
      addable: true,
      filterable: true
    }
  },
}