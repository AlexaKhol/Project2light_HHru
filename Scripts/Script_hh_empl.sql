--Запрос 1 для поиска средних, минимальных и высоких уровней зарплат в категориях "от" и "до" 
--Для выполнения данного запроса необходимо использовать агрегирующие функции по соответсвующим полям
--в датасете.
SELECT ROUND(AVG(salary_from),2) AS avg_salary_from, 
ROUND(AVG(salary_to),2) AS avg_salary_to,
MIN(salary_from) AS min_salary_from,
MIN(salary_to) AS min_salary_to,
MAX(salary_from) AS max_salary_from,
MAX(salary_to) AS max_salary_to
FROM public.parcing_table;
--Запрос 2 для поиска регионов, в которых сосредоточено наибольшее кол-во объявлений
SELECT area,COUNT(id) AS num_vac
FROM public.parcing_table
GROUP BY area
ORDER BY num_vac DESC;
--Запрос 3 для поиска компаний, в которых сосредоточено наибольшее кол-во объявлений
SELECT employer,COUNT(id) AS num_vac
FROM public.parcing_table
GROUP BY employer
ORDER BY num_vac DESC;
--Запрос 4 для определения преобладающих типов занятости
SELECT employment,COUNT(id) AS num_vac
FROM public.parcing_table
GROUP BY employment 
ORDER BY num_vac DESC;
--Запрос 5 для определения преобладающих типов  графиков работы
SELECT schedule,COUNT(id) AS num_vac
FROM public.parcing_table
GROUP BY schedule 
ORDER BY num_vac DESC;
--Запрос 6 для определения распределения грейдов по опыту среди аналитиков данных и системных аналитиков
SELECT experience,COUNT(id) AS num_vac
FROM public.parcing_table
GROUP BY experience 
ORDER BY num_vac DESC;
--Запрос 7 для определения долей грейдов среди вакансий
--Определены форматы введения вакансий при изучениии датасета с помощью вывода данных, например,
--SELECT name 
--FROM public.parcing_table
--LIMIT 20;
--Код для расчета общего кол-ва вакансий - В РЕЗУЛЬТАТЕ ВЫПОЛНЕНИЯ КОДА получилось 1326 вакансий 
--SELECT COUNT(*) 
--FROM public.parcing_table 
--WHERE name LIKE '%Аналитик данных%' 
   --OR name LIKE '%аналитик данных%'
   --OR name LIKE '%Системный аналитик%'
   --OR name LIKE '%системный аналитик%';
SELECT experience,
       COUNT(*) AS num_vac,
       ROUND(COUNT(*) * 100.0 / 1326, 2) AS percent_vac
FROM public.parcing_table
WHERE name LIKE '%Аналитик данных%' 
   OR name LIKE '%аналитик данных%'
   OR name LIKE '%Системный аналитик%'
   OR name LIKE '%системный аналитик%'
GROUP BY experience
ORDER BY percent_vac DESC;
--Запрос 8 для выявления основных работодателей (указать запраты и условия труда) для аналитиков данных и 
--системных аналитиков
SELECT employer,COUNT(id) AS num_vac, ROUND(AVG(salary_from),2) AS avg_salary_from, 
ROUND(AVG(salary_to),2) AS avg_salary_to, schedule, employment
FROM public.parcing_table
WHERE name LIKE '%Аналитик данных%' OR name LIKE '%аналитик данных%' OR name LIKE '%Системный аналитик%' OR name LIKE '%системный аналитик%'
GROUP BY employer, schedule, employment
ORDER BY num_vac DESC;
--Запрос 9 для определения наиболее востребованных навыков для различных грейдов и позиций
SELECT key_skills_1, experience, COUNT(*) AS quant_numb
FROM public.parcing_table
WHERE key_skills_1 IS NOT NULL
GROUP BY key_skills_1, experience
ORDER BY quant_numb DESC;


