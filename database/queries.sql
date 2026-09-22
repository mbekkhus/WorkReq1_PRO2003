-- Query 1:
-- Shows every workout program with its exercises in the planned order. 

SELECT 
  wp.name AS program_name,
  e.name AS exercise_name,
  pe.sets,
  pe.repetitions,
  pe.target_rir,
  pe.exercise_order
FROM workout_program AS wp
JOIN program_exercise AS pe 
  ON wp.id = pe.program_id
JOIN exercise AS e
  ON pe.exercise_id = e.id
ORDER BY wp.id, pe.exercise_order;

-- Query 2:
-- Counts the number of exercises in each workout program. 

SELECT 
  wp.name AS program_name,
  COUNT(pe.exercise_id) AS number_of_exercises
FROM workout_program AS wp
JOIN program_exercise AS pe 
  ON wp.id = pe.program_id
GROUP BY wp.id, wp.name
ORDER BY number_of_exercises DESC, wp.name;

-- Query 3:
-- Shows workout programs containing more than six exercises. 

SELECT 
  wp.name AS program_name,
  COUNT(pe.exercise_id) AS number_of_exercises
FROM workout_program AS wp 
JOIN program_exercise AS pe 
  ON wp.id = pe.program_id
GROUP BY wp.id, wp.name
HAVING COUNT(pe.exercise_id) > 6
ORDER BY number_of_exercises DESC, wp.name;

-- Query 4:
-- Summarizes sets, repetitions, and target RIR for each workout program. 

SELECT
  wp.name AS program_name,
  SUM(pe.sets) AS total_sets,
  ROUND(AVG(pe.repetitions), 1) AS average_repetitions,
  MIN(pe.target_rir) AS lowest_target_rir,
  MAX(pe.target_rir) AS highest_target_rir
FROM workout_program AS wp
JOIN program_exercise AS pe
  ON wp.id = pe.program_id
GROUP BY wp.id, wp.name
ORDER BY wp.name;

-- Query 5:
-- Shows exercises prescribed with more sets than the average across all programs.
-- A scalar subquery is suitable because the outer query only needs one calculated average value for comparison.
-- A JOIN would make this particular query less direct. 

SELECT
  wp.name AS program_name,
  e.name AS exercise_name,
  pe.sets
FROM workout_program AS wp
JOIN program_exercise AS pe
  ON wp.id = pe.program_id
JOIN exercise AS e
  ON pe.exercise_id = e.id
WHERE pe.sets > (
  SELECT AVG(sets)
  FROM program_exercise
)
ORDER BY pe.sets DESC, wp.name, e.name;

-- Query 6: 
-- Shows every user and the number of workout programs they own. 
-- Users without a workout program are also included. 

SELECT 
  au.name AS user_name,
  COUNT(wp.id) AS number_of_programs
FROM app_user AS au
LEFT JOIN workout_program AS wp
  ON au.id = wp.user_id
GROUP BY au.id, au.name
ORDER BY number_of_programs DESC, au.name;

-- Query 7:
-- Shows how many exercises are available for each muscle group.

SELECT
  muscle_group,
  COUNT(*) AS number_of_exercises
FROM exercise
GROUP BY muscle_group
ORDER BY number_of_exercises DESC, muscle_group;

-- Query 8:
-- Shows how many workout programs use each exercise.
-- Exercises that are not assigned to a program are also included.

SELECT
  e.name AS exercise_name,
  e.muscle_group,
  COUNT(DISTINCT pe.program_id) AS number_of_programs
FROM exercise AS e
LEFT JOIN program_exercise AS pe
  ON e.id = pe.exercise_id
GROUP BY e.id, e.name, e.muscle_group
ORDER BY number_of_programs DESC, e.name;
