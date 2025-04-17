USE project_hr;
SELECT * 
FROM hr;

ALTER table hr
CHANGE COLUMN id emp_id VARCHAR(20)NULL;

DESCRIBE hr;

SELECT birthdate FROM hr;
UPDATE hr
SET birthdate = CASE
					WHEN birthdate LIKE '%-%' THEN STR_TO_DATE(birthdate,'%m-%d-%Y')
					ELSE NULL
				END;
    
SELECT hire_date 
FROM hr;

UPDATE hr
SET hire_date = CASE
					WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
					ELSE NULL
				END;
    
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d')), '0000-00-00');

SET sql_mode = 'ALLOW_INVALID_DATES';

SELECT termdate FROM hr;
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr 
ADD COLUMN age INT;
SELECT* FROM hr;

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR,birthdate,CURDATE());

SELECT COUNT(*) FROM hr
WHERE age < 18 ;