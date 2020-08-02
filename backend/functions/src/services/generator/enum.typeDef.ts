export default function(currentEnum: object) {
  return {
    id: {
      resolver: async (context, req, currentObject, query, args) => {
        return args.id;
      }
    },
    name: {
      resolver: async (context, req, currentObject, query, args) => {
        return currentEnum[args.id]
      }
    }
  }
};