-- Noticed that some of "time" column values had '\N' values, so I decided to replace them with NULL value instead
UPDATE "races" SET "time" = NULL
WHERE "time" = "\N";

-- Additionally, I Noticed that some drivers didnt have a code name, so figured I could create those with a query
UPDATE "drivers" SET "code_name" = (
    SELECT UPPER(SUBSTR("last_name", 1, 3))
)
WHERE "code_name" = '\N';
