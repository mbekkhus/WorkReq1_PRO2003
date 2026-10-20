-- Database users and privileges for the strength training database.
-- Replace the placeholder passwords locally. Do not commit real passwords.

-- Read-only user, for example for reports. 
CREATE USER workout_reader WITH PASSWORD 'change_me_reader';

GRANT SELECT 
ON app_user, workout_program, exercise, program_exercise
TO workout_reader; 

-- Application user, used by the backend instead of an administrator account. 
CREATE USER workout_app WITH PASSWORD 'change_me_app';

GRANT SELECT, INSERT, UPDATE
ON app_user
TO workout_app; 

GRANT SELECT, INSERT, UPDATE, DELETE
ON workout_program, program_exercise
TO workout_app;

GRANT SELECT 
ON exercise
TO workout_app;