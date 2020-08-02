import generatePaginatorTypeDef from './generator/paginator.typeDef'

import { BingoTile, BingoRound } from './services'

import user from './user/user.typeDef'

import bingoTile from './bingoTile/bingoTile.typeDef'

import bingoRound from './bingoRound/bingoRound.typeDef'

export const typeDefs = {
  user,
  bingoTile,
  bingoTilePaginator: generatePaginatorTypeDef(BingoTile),
  bingoRound,
  bingoRoundPaginator: generatePaginatorTypeDef(BingoRound),
}