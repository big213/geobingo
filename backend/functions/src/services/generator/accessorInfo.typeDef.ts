export default function(service: any) {
  return {
    permissions: {
      resolver: async (context, req, currentObject, query, args) => {
        return service.getRecords(req, {
          ...args
        }, null, true);
      }
    },
    sufficientPermissions: {
      resolver: async (context, req, currentObject, query, args) => {
        return service.testPermissions('get', req);
      }
    }
  }
};