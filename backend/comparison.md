**Pros**

- Automatically exposes a mirrored restful API without much additional effort

Example:

To get a user, you could use the graphql endpoint: `POST https://us-central1-jql-boilerplate.cloudfunctions.net/api/graphql`

or you could use traditional REST methods to get a preset response, `GET https://us-central1-jql-boilerplate.cloudfunctions.net/api/user/1` How does this allow graphing? or is this not supposed to allow graphing?

- Uses JSON as the query language, which might be more readily consumable by js frontends.

- Allows for more efficient querying strategies (I am not 100% sure if this is possible onr ot in graphql, and maybe this is something I should look at in more detail).

Example:

```
{
	"action": "getReviews",
	"query": {
		"data": {
			"id": null,
			"created_by": {
				"id": null,
				"name": null
			}
		},
		"__args": {
			"user_id": 2
		}
	}
}
```

In traditional Graphql, my understanding is that the database querying strategy for the following kind of query (using the dataloader batching) is:

1. `SELECT id, created_by FROM review where created_by=2` O(log(N))
2. `SELECT id, name FROM user WHERE id IN(1,2,3,4,5...)` O(K * log(M)) (K=number of reviews found)
3. (join user with review->created_by field in javascript)

Using jql, I was able to implement joining in mysql directly, resulting in slightly fewer mysql connections, which I assume is a good thing:

1. `SELECT review.id AS "id", user.id AS "created_by.id", user.name AS "created_by.name", "user" AS "created_by.__typename", "review" AS "__typename" FROM review LEFT JOIN user ON review.created_by = user.id WHERE (review.created_by = 2)` O(N * log(M) * log(M)), by moving the review.created_by = 2 from WHERE into ON, you will get O(N * log(M))
2. (collapse the object in javascript)

Furthermore, there is the ability to use custom resolvers for certain fields that are not accessible in mysql, or cannot be fetched in one single query. This is also very well supported by GraphQL

- Ability to query a raw field ID (i.e. not required to drill down if you only need the ID)

Example:
```
{
	"action": "getReviews",
	"query": {
		"data": {
			"id": null,
			"created_by": null
		},
		"__args": {
			"user_id": 2
		}
	}
}
```

**Cons**

- Has no broader eco-system, like graphql has

- Is (currently) a subset of graphql in terms of functionality, except for the few points I brought up in "pros" section.

- No type and null checking (as of yet)

- No graphql-playground