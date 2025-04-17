-- gender breakdown

SELECT gender,COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY gender;


-- race breakdown

SELECT race,COUNT(*) AS count 
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY count DESC;


-- age distribution

SELECT
	CASE WHEN age >= 18 AND age <= 24 THEN '18-24'
		 WHEN age >= 25 AND age <= 34 THEN '25-34'
         WHEN age >= 35 AND age <= 44 THEN '35-44'
		 WHEN age >= 45 AND age <= 54 THEN '45-54'
         WHEN age >= 55 AND age <= 64 THEN '55-64'
		 ELSE '65+'
	END AS age_group,gender,
    COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group,gender
ORDER BY age_group,gender;


-- work location

SELECT location,COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location;


-- average length of employment

SELECT ROUND(AVG(DATEDIFF(termdate,hire_date))/365,0) AS avg_year
FROM hr
WHERE termdate < CURDATE() AND termdate <> '0000-00-00' AND age >= 18;


-- gender distribution vary across departments

SELECT department,gender,COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department,gender
ORDER BY department;


-- jobtitle distribution

SELECT jobtitle,COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle;


-- turnover rate of each department

SELECT department,
	   total_count,
       terminated_count,
       terminated_count/total_count AS terminated_rate
FROM (
	SELECT department,
		   COUNT(*) AS total_count,
           SUM(CASE WHEN termdate != '0000-00-00' AND termdate <= CURDATE() THEN 1
		            ELSE 0
		       END) AS terminated_count
    FROM hr
    WHERE age >= 18
    GROUP BY department) AS t
ORDER BY terminated_rate DESC;


-- location_state distribution 

SELECT location_state,COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY count DESC;


-- employee count changed over time based on hire and term dates

SELECT
	year,
    hires,
    terminations,
    hires-terminations AS net_change,
    ROUND((hires-terminations)/hires*100,2) AS net_change_percent
FROM (
	SELECT 
		YEAR(hire_date) AS year,
        COUNT(*) AS hires,
        SUM(CASE WHEN termdate != '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
	FROM hr
    WHERE age >= 18
    GROUP BY year) AS y
ORDER BY year;


-- tenure distribution of each department

SELECT 
	department,
    ROUND(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM hr
WHERE termdate <= CURDATE() AND termdate != '0000-00-00' AND age >= 18
GROUP BY department

