-- Indexes for faster JOINs and filtering

-- Optimize race-based queries
CREATE INDEX idx_results_race ON results(race_id);
CREATE INDEX idx_sprint_race ON sprint_results(race_id);

-- Optimize driver-based queries
CREATE INDEX idx_results_driver ON results(driver_id);
CREATE INDEX idx_sprint_driver ON sprint_results(driver_id);

-- Optimize constructor queries
CREATE INDEX idx_results_constructor ON results(constructor_id);
CREATE INDEX idx_sprint_constructor ON sprint_results(constructor_id);

-- Optimize year-based filtering
CREATE INDEX idx_races_year ON races(year);

-- For nationality-based filtering
CREATE INDEX idx_drivers_nationality ON drivers(nationality);
CREATE INDEX idx_constructors_nationality ON constructors(nationality);
