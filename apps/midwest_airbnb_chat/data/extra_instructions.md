# Extra Instructions

Rules the LLM follows when it writes SQL for `listings`.

- `price` is the nightly price in U.S. dollars. When the user asks what something costs, use `price` and round money to whole dollars in the answer.
- When filtering by city, match case-insensitively using `LOWER(city) = LOWER('city_name')` (e.g., `'Chicago'`, `'Columbus'`, or `'Twin Cities'`).
- Always exclude `NULL` values when computing average ratings: `WHERE review_scores_rating IS NOT NULL`.