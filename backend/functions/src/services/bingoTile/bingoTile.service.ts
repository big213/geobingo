import Service from '../service';
import generatePaginatorService from '../generator/paginator.service';

//import primitiveResolverHelper from '../helpers/tier2/primitiveResolver';

export class BingoTile extends Service {
  static __typename = 'bingoTile';
  static paginator = generatePaginatorService(BingoTile);
  
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
    bingoRound: {
      field: "bingoRound",
    },
  };

  static isFilterRequired = false;

  static searchableFields = [];

  static sortFields = ["position"];
  
  static accessControl = {
    get: () => true,
    getMultiple: () => true,
    add: () => true,
    update: () => true,
    delete: () => true,
  };
};