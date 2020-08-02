import generatePaginatorInfoService from './paginatorInfo.service'

export default function(service: any) {
  const PaginatorInfo = generatePaginatorInfoService(service);

  return {
    paginatorInfo: {
      __typename: PaginatorInfo.__typename,
      resolver: async (context, req, currentObject, query, args) => {
        return PaginatorInfo.getRecord(req, {
          ...args
        }, query);
      },
    },
    data: {
      __typename: service.__typename,
      resolver: async (context, req, currentObject, query, args) => {
        return service.getRecords(req, {
          ...args
        }, query);
      }
    },
  }
};