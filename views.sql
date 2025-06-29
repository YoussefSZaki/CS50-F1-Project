-- We will create a view showing the drivers who only gained positions in a race
-- As the difference between the final classification and the grid position
CREATE VIEW "positions_gained" AS
SELECT "race_id", "driver_id", "starting_position", "final_classification",
    ("starting_position" - "final_classification") AS "positions_gained"
FROM "results"
WHERE final_classification IS NOT NULL AND positions_gained >= 0
ORDER BY "positions_gained" DESC;

-- Then created a view to summarize total points per driver per season (main + sprint)
CREATE VIEW driver_season_points AS
SELECT
    drivers.id AS driver_id,
    drivers.first_name,
    drivers.last_name,
    races.year,
    SUM(results.points + sprint_results.points) AS total_points
FROM results
JOIN sprint_results
    ON results.race_id = sprint_results.race_id
    AND results.driver_id = sprint_results.driver_id
JOIN races ON races.id = results.race_id
JOIN drivers ON drivers.id = results.driver_id
GROUP BY drivers.id, races.year
ORDER BY races.year DESC, total_points DESC;
