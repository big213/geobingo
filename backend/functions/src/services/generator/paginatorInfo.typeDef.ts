export default function(service: any) {
  return {
    total: {
      resolver: async (context, req, currentObject, query, args) => {
        return service.getRecords(req, {
          ...args,
          after: null
        }, null, true);
      }
    },
    count: {
      resolver: async (context, req, currentObject, query, args) => {
        return Math.min(args.first || Infinity, await service.getRecords(req, {
          ...args
        }, null, true));
      }
    },
  }
};