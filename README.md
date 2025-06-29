# Formula 1 Racing Database (CS50 SQL Final Project)

👋 Hi! I'm Youssef Zaki, and this is a showcase of my final project for Harvard's CS50 SQL course.

This project is not a product or library — it is designed to demonstrate my ability to model complex data, write clean SQL, and build a relational database from real-world CSV data.

---

**Contents:**

- ER diagram
- Database schema and constraints
- Indexing and optimization
- SQL queries for analysis
- Data cleaning decisions
- Project limitations

---
# Design Document

## Scope

The Formula 1 Racing Database includes all entities necessary to track historical race data, driver performance, and team participation in Formula 1 events. Included in the database's scope is:

* Circuits, including location information
* Drivers, including biographical details and performance metrics
* Constructors (teams), including nationality information
* Races, including scheduling and location data
* Race results (both main and sprint events)
* Finish status categories

Out of scope are elements like pit stop times, tire strategies, engine specifications, and financial data about teams or drivers.

## Functional Requirements

This database will support:

* Tracking driver performance across multiple seasons
* Analyzing position changes during races
* Calculating championship points by driver/constructor
* Comparing results between main races and sprint races
* Identifying exceptional performances (e.g., wins from poor starting positions)

Note that in this iteration, the system will not support real-time race data or predictive analytics.

## Representation

Entities are captured in SQLite tables with the following schema.
![ER Diagram](docs/F1_ERDiagram(3).png)

### Entities

The database includes the following entities:

#### Circuits

The `circuits` table includes:
* `id` as `INTEGER PRIMARY KEY` - Unique circuit identifier
* `name` as `TEXT NOT NULL` - Official circuit name
* `city` as `TEXT NOT NULL` - Host city location
* `country` as `TEXT NOT NULL` - Host country

#### Drivers

The `drivers` table includes:
* `id` as `INTEGER PRIMARY KEY` - Unique driver identifier
* `code_name` as `TEXT` - 3-letter driver code (generated from surname if null)
* `first_name` as `TEXT NOT NULL` - Driver's given name
* `last_name` as `TEXT NOT NULL` - Driver's family name
* `date_of_birth` as `NUMERIC NOT NULL` - Birth date
* `nationality` as `TEXT NOT NULL` - Driver's country

#### Constructors

The `constructors` table includes:
* `id` as `INTEGER PRIMARY KEY` - Unique team identifier
* `name` as `TEXT NOT NULL` - Official team name
* `nationality` as `TEXT NOT NULL` - Team's country

#### Races

The `races` table includes:
* `id` as `INTEGER PRIMARY KEY` - Unique race identifier
* `year` as `INTEGER` - Season year
* `round` as `INTEGER` - Race number in season
* `circuit_id` as `INTEGER NOT NULL` - Reference to circuits table
* `name` as `TEXT NOT NULL` - Official race name
* `date` as `INTEGER` - Race date
* `time` as `INTEGER` - Start time (nullable)

Foreign key constraint ensures each race occurs at a valid circuit.

#### Status

The `status` table includes:
* `id` as `INTEGER PRIMARY KEY` - Status identifier
* `status` as `TEXT NOT NULL` - Finish description (e.g., "Finished", "Accident")

#### Results

The `results` table includes:
* `id` as `INTEGER PRIMARY KEY` - Result identifier
* `race_id` as `INTEGER NOT NULL` - Reference to races table
* `driver_id` as `INTEGER NOT NULL` - Reference to drivers table
* `constructor_id` as `INTEGER NOT NULL` - Reference to constructors table
* `starting_position` as `INTEGER` - Grid position (nullable)
* `final_classification` as `INTEGER` - Finishing position (nullable)
* `finish_category` as `TEXT` - Position text (includes DNF codes)
* `points` as `INTEGER` - Points earned
* `status_id` as `INTEGER NOT NULL` - Reference to status table

Foreign keys maintain data integrity across relationships.

#### Sprint Results

The `sprint_results` table mirrors the structure of `results` to track sprint race outcomes separately.

### Relationships

The entity relationship diagram describes these key relationships:

* One circuit hosts many races (one-to-many)
* One driver has many race results (one-to-many)
* One constructor has many race entries (one-to-many)
* One race has many finishing positions (one-to-many)
* One status can apply to many results (one-to-many)

Additional relationships:
* Drivers belong to constructors through race entries
* Races have both main and sprint results (separate but related tables)

## Optimizations

1. **positions_gained view**:
   - Pre-calculates position changes (starting_position - final_classification)
   - Filters out DNFs (NULL final_classification)
   - Sorts by largest position gains for quick analysis

2. **driver_season_points view**:
   - Aggregates each driver's total points per season, combining main and sprint race results
   - Allows fast queries for championship summaries without duplicating join logic

3. **Indexes**:
   - Created on frequently joined columns (race_id, driver_id)
   - Recommended for performance:
     - `idx_results_race` on results(race_id)
     - `idx_results_driver` on results(driver_id)
     - `idx_races_year` on races(year)
     - `idx_sprint_race` on sprint_results(race_id)
     - `idx_sprint_driver` on sprint_results(driver_id)
     - `idx_results_constructor` on results(constructor_id)
     - `idx_sprint_constructor` on sprint_results(constructor_id)
     - `idx_drivers_nationality` on drivers(nationality)
     - `idx_constructors_nationality` on constructors(nationality)

4. **Data Cleaning**:
   - Replaced '\N' placeholders with NULL in race time data to ensure compatibility with numeric operations and proper sorting.
   - Some drivers were missing 3-letter code names in the original dataset. These were auto-generated from the driver’s last name.

## Limitations

1. **Data Constraints**:
   - No lap-by-lap position tracking
   - Doesn't account for changing point systems across eras
   - Limited historical data based on CSV imports

2. **Performance Considerations**:
   - Seasonal point calculations may slow with extensive history
   - No partitioning by year for large datasets

3. **Missing Relationships**:
   - No direct link between sprint and main race results
   - No engine manufacturer tracking
   - No tire strategy information

4. **Data Quality**:
   - Dependent on source CSV accuracy
   - Some time values may be incomplete
   - Driver codes are generated if missing

## 📦 Data Source

The data used in this project was sourced from Kaggle:

**Formula 1 World Championship (1950–2020)**  
🔗 [Kaggle Dataset by Rohan Rao](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020/discussion)

This dataset includes historical information on circuits, drivers, constructors, races, results, and sprint outcomes.  
This project is for educational and demonstrative purposes only. Data ownership and licensing remain with the original dataset authors and sources.
