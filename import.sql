-- First we import our csv files to be used in our tables
.import --csv circuits.csv circuits_temp
.import --csv drivers.csv drivers_temp
.import --csv races.csv races_temp
.import --csv results.csv results_temp
.import --csv constructors.csv constructors_temp
.import --csv status.csv status_temp
.import --csv sprint_results.csv sprint_temp

-- We then created our tables with specific type affinities and column constraints through our schema
-- And then we insert our needed data to created tables
INSERT INTO "circuits"("id", "name", "city", "country")
SELECT "circuitId", "name", "location", "country" FROM "circuits_temp";

INSERT INTO "drivers"("id", "code_name", "first_name", "last_name", "date_of_birth", "nationality")
SELECT "driverId", "code", "forename", "surname", "dob", "nationality" FROM "drivers_temp";

INSERT INTO "constructors"("id", "name", "nationality")
SELECT "constructorId", "name", "nationality" FROM "constructors_temp";

INSERT INTO "races"("id", "year", "round", "circuit_id", "name", "date", "time")
SELECT "raceId", "year", "round", "circuitId", "name", "date", "time" FROM "races_temp";

INSERT INTO "status"("id", "status")
SELECT "statusId", "status" FROM "status_temp";

INSERT INTO "results"("id", "race_id", "driver_id", "constructor_id", "starting_position", "final_classification",
"finish_category", "points", "status_id")
SELECT "resultId", "raceId", "driverId", "constructorId", "grid", "positionOrder", "positionText", "points", "statusId"
FROM "results_temp";

INSERT INTO "sprint_results"("id", "race_id", "driver_id", "constructor_id", "starting_position", "final_classification",
"finish_category", "points", "status_id")
SELECT "resultId", "raceId", "driverId", "constructorId", "grid", "positionOrder", "positionText", "points", "statusId"
FROM "sprint_temp";
