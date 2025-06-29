-- Here I compiled some of the most common queries that can run on the database

-- Find all constructors given a specific nationality
SELECT * FROM "constructors"
WHERE "nationality" = "British";

-- Find all drivers given a specific nationality
SELECT * FROM "drivers"
WHERE "nationality" = "Italian";

-- Find all races won by a specific driver
SELECT "races"."year", "races"."name" AS "Grand Prix", "circuits"."name" AS "Circuit" FROM "races"
JOIN "circuits" ON "circuits"."id" = "races"."circuit_id"
JOIN "results" ON "results"."race_id" = "races"."id"
JOIN "drivers" ON "drivers"."id" = "results"."driver_id"
WHERE "results"."final_classification" = 1
AND "drivers"."first_name" = "Max"
AND "drivers"."last_name" = "Verstappen";

-- Drivers by position gained who ended up winning the race starting from outside the top 10
SELECT "drivers"."first_name", "drivers"."last_name", "races"."name",
"starting_position", "final_classification", "positions_gained", "races"."year"
FROM "positions_gained"
JOIN "drivers" ON "drivers"."id" = "positions_gained"."driver_id"
JOIN "races" ON "races"."id" = "positions_gained"."race_id"
WHERE "final_classification" = 1 AND "starting_position" > 10
ORDER BY "positions_gained" DESC, "year" DESC, "last_name" ASC;

-- Find all points scored by a specific driver by season
SELECT "races"."year", SUM("results"."points" + "sprint_results"."points") AS "total_points" FROM "results"
JOIN "drivers" ON "drivers"."id" = "results"."driver_id" AND "drivers"."id" = "sprint_results"."driver_id"
JOIN "races" ON "races"."id" = "results"."race_id" AND "races"."id" = "sprint_results"."race_id"
WHERE "drivers"."first_name" = "Lewis" AND "drivers"."last_name" = "Hamilton"
GROUP BY ("year")
ORDER BY "year" DESC;
