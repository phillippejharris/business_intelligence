# Midwest Airbnb Listings: Data Dictionary

**Dataset:** `listings` table in `midwest_airbnb.db` (SQLite), 14,887 rows and 29 columns
**Source:** Inside Airbnb (https://insideairbnb.com/get-the-data/), the detailed `listings.csv.gz` file for each of three regions: Chicago (snapshot 2026-07-20), Columbus (snapshot 2026-07-23), and Twin Cities MSA (snapshot 2026-07-21). Column meanings follow Inside Airbnb's data dictionary and assumptions (https://insideairbnb.com/data-assumptions/).
**Course:** ISA 401, Miami University

> One row is one listing that showed a nightly price on the snapshot date; listings with no price were dropped. Empty cells are stored as SQL `NULL`.

---

## Field Definitions

| Field | Type | Description |
|---|---|---|
| `city` | text | Which Inside Airbnb region the listing came from: `Chicago` (7,439 rows), `Columbus` (2,587), or `Twin Cities` (4,861). The Twin Cities file covers the Minneapolis-St. Paul metro area, not just the two cities. |
| `snapshot_date` | text | Date Inside Airbnb compiled the file, stored as an ISO text string, not a date: `2026-07-20` for Chicago, `2026-07-23` for Columbus, `2026-07-21` for Twin Cities. Every row of a city shares the same value. |
| `id` | text | Airbnb's listing id. Unique across the table (14,887 distinct values). Stored as text even though it looks numeric, so compare it to a quoted string. |
| `name` | text | Listing title as shown on Airbnb (for example "Tiny Studio Apartment 94 Walk Score"). Never empty. |
| `price` | real | Nightly price in U.S. dollars on the snapshot date, with the dollar sign and commas removed. Ranges from 2.56 to 11,412; never `NULL` (rows without a price were dropped). |
| `room_type` | text | Airbnb's four listing categories: `Entire home/apt` (11,652 rows), `Private room` (2,951), `Hotel room` (246), or `Shared room` (38). |
| `host_id` | text | Airbnb's unique identifier for the host |
| `host_name` | text | First name of the host |
| `host_since` | text | Date the host created their Airbnb account (YYYY-MM-DD) |
| `host_is_superhost` | text | Boolean flag indicating if host is a Superhost (`t` for true, `f` for false) |
| `neighbourhood` | text | Cleaned neighborhood name derived from primary location data |
| `latitude` | real | Latitude coordinate of the listing in decimal degrees |
| `longitude` | real | Longitude coordinate of the listing in decimal degrees |
| `property_type` | text | Categorical description of accommodation type (e.g., `Entire rental unit`, `Private room in home`) |
| `accommodates` | integer | Maximum capacity of total guests allowed |
| `bedrooms` | integer | Total number of dedicated bedrooms |
| `beds` | integer | Total number of bed options provided |
| `bathrooms_text` | text | Raw text string describing bathroom count and type (e.g., `1 bath`, `2.5 shared baths`) |
| `bathrooms` | real | Numeric count of total bathrooms |
| `minimum_nights` | integer | Minimum duration of stay required in nights |
| `maximum_nights` | integer | Maximum allowed stay duration in nights |
| `number_of_reviews` | integer | Cumulative total review count for the listing |
| `number_of_reviews_ltm` | integer | Total review count received in the last twelve months |
| `number_of_reviews_l30d` | integer | Total review count received in the last thirty days |
| `review_scores_rating` | real | Overall average guest review score rating (0–5 scale) |
| `review_scores_value` | real | Average rating guest review score for value (0–5 scale) |
| `reviews_per_month` | real | Historical average number of review submissions per month |
| `calculated_host_listings_count` | integer | Total count of active listings managed by the same host |
| `availability_365` | integer | Total number of available days to reserve within the next 365 days |
