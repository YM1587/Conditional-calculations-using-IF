-- Conditional calculations using IF
-- using  IF and nested IF statements to replace missing data based on certain criteria.
-- 1. Replace NULL values for Central and Southern Asia
-- Write an IF statement that checks whether the Region is Central and Southern Asia and whether 
-- Pct_unemployment is NULL. If both conditions are met, set the value of a new alias column called 
-- New_pct_unemployment to 19.59. If the conditions are not met, use -999 as a placeholder value in the 
-- New_pct_unemployment column.

use united_nations;

SELECT 
	Region,
    Pct_unemployment,
    IF((Region = "Central and Southern Asia") and (Pct_unemployment IS NULL),19.59,-999)
    AS New_Pct_unemployment
FROM access_to_basic_services;

-- let's do this in new diffrent way using  CASE statement or modify your IF statement to preserve existing values.
-- Option 1: Using IF statement
SELECT 
	Region,
    Pct_unemployment,
    IF((Region = "Central and Southern Asia") and (Pct_unemployment IS NULL),19.59,Pct_unemployment)
    AS New_Pct_unemployment
FROM access_to_basic_services;

-- Option 2: Using CASE statement (recommended)
-- CASE is more readable and maintainable, especially when you have multiple conditions. It's explicit about 
-- what you're checking and what you're doing. As your logic gets more complex, CASE scales better:
SELECT 
    Region,
    Pct_unemployment,
    CASE 
        WHEN (Region = "Central and Southern Asia") AND (Pct_unemployment IS NULL) THEN 19.59
        ELSE Pct_unemployment
    END AS New_Pct_unemployment
FROM access_to_basic_services;

-- 2.  Replace NULL values for Eastern and South-Eastern Asia

SELECT 
	Region,
    Pct_unemployment,
    IF((Region = "Central and Southern Asia") and (Pct_unemployment IS NULL),19.59,
		IF((Region = "Eastern and South-Eastern Asia") AND (Pct_unemployment IS NULL),22.64,-999)
	)
    AS New_Pct_unemployment
FROM access_to_basic_services;

-- 3. Replace NULL values for remaining regions
SELECT Region,
       Pct_unemployment,
       IF( (Region = "Central and Southern Asia") AND (Pct_unemployment IS NULL), 19.59,
            IF( (Region = "Eastern and South-Eastern Asia") AND (Pct_unemployment IS NULL), 22.64,
                 IF( (Region = "Europe and Northern America") AND (Pct_unemployment IS NULL), 24.43,
                      IF( (Region = "Latin America and the Caribbean") AND (Pct_unemployment IS NULL), 24.23,
                           IF( (Region = "Northern Africa and Western Asia") AND (Pct_unemployment IS NULL), 17.84,
                                IF( (Region = "Oceania") AND (Pct_unemployment IS NULL), 4.98,
                                     IF( (Region = "Sub-Saharan Africa") AND (Pct_unemployment IS NULL), 33.65,
                                          -999
                                         )
                                    )
                               )
                          )
                     )
                )
           )AS New_pct_unemployment
FROM united_nations.Access_to_Basic_Services;

-- 4. Replace the placeholder value
SELECT 
    Region,
    Pct_unemployment,
    IF((Region = "Central and Southern Asia") AND (Pct_unemployment IS NULL), 19.59,
        IF((Region = "Eastern and South-Eastern Asia") AND (Pct_unemployment IS NULL), 22.64,
            IF((Region = "Europe and Northern America") AND (Pct_unemployment IS NULL), 24.43,
                IF((Region = "Latin America and the Caribbean") AND (Pct_unemployment IS NULL), 24.23,
                    IF((Region = "Northern Africa and Western Asia") AND (Pct_unemployment IS NULL), 17.84,
                        IF((Region = "Oceania") AND (Pct_unemployment IS NULL), 4.98,
                            IF((Region = "Sub-Saharan Africa") AND (Pct_unemployment IS NULL), 33.65,
                                Pct_unemployment
                            )
                        )
                    )
                )
            )
        )
    ) AS New_pct_unemployment
FROM united_nations.Access_to_Basic_Services;
