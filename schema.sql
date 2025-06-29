-- This represents all circuits availabe for racing
CREATE TABLE "circuits"(
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

-- This represents all drivers' data
CREATE TABLE "drivers"(
    "id" INTEGER,
    "code_name" TEXT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "date_of_birth" NUMERIC NOT NULL,
    "nationality" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

-- This represents all constructors' data
CREATE TABLE "constructors"(
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "nationality" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

-- This represents all races
CREATE TABLE "races"(
    "id" INTEGER,
    "year" INTEGER,
    "round" INTEGER,
    "circuit_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "date" INTEGER,
    "time" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("circuit_id") REFERENCES "circuits"("id")
);

-- This represent all finish status of cars
CREATE TABLE "status"(
    "id" INTEGER,
    "status" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- This represents all results of all races
CREATE TABLE "results"(
    "id" INTEGER,
    "race_id" INTEGER NOT NULL,
    "driver_id" INTEGER NOT NULL,
    "constructor_id" INTEGER NOT NULL,
    "starting_position" INTEGER,
    "final_classification" INTEGER,
    "finish_category" TEXT,
    "points" INTEGER,
    "status_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("race_id") REFERENCES "races"("id"),
    FOREIGN KEY("driver_id") REFERENCES "drivers"("id"),
    FOREIGN KEY("constructor_id") REFERENCES "constructors"("id"),
    FOREIGN KEY("status_id") REFERENCES "status"("id")
);

-- This represents all results of all races
CREATE TABLE "sprint_results"(
    "id" INTEGER,
    "race_id" INTEGER NOT NULL,
    "driver_id" INTEGER NOT NULL,
    "constructor_id" INTEGER NOT NULL,
    "starting_position" INTEGER,
    "final_classification" INTEGER,
    "finish_category" TEXT,
    "points" INTEGER,
    "status_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("race_id") REFERENCES "races"("id"),
    FOREIGN KEY("driver_id") REFERENCES "drivers"("id"),
    FOREIGN KEY("constructor_id") REFERENCES "constructors"("id"),
    FOREIGN KEY("status_id") REFERENCES "status"("id")
);

