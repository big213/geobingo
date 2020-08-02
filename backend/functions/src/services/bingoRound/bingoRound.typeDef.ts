import { User, BingoTile } from '../services';

export default {
  id: {
    mysqlOptions: {
      filterable: true
    }
  },
  name: {
    mysqlOptions: {
      addable: true
    }
  },
  length: {
    mysqlOptions: {
      addable: true
    }
  },
  created_by: {
    __typename: User.__typename,
    mysqlOptions: {
      addable: true,
      joinInfo: {}
    },
  },
  date_created: {
    mysqlOptions: {
      addable: true
    }
  },
  date_modified: {
    mysqlOptions: {
      addable: true
    }
  },
  bingoTiles: {
    __typename: BingoTile.__typename,
    resolver: async (context, req, currentObject, query, args, parent) => {
      return BingoTile.paginator.getRecord(req, {
        ...query?.__args,
        bingoRound: currentObject.id
      }, query);
    }
  }
}