-- Transaction 1: Create a workout program together with its exercises.
-- Both inserts must succeed together, otherwise nothing is saved. 

BEGIN;

INSERT INTO workout_program (user_id, name, description)
VALUES (4, 'Transaction Test', 'Created to test a transaction.');

INSERT INTO program_exercise (program_id, exercise_id, sets, repetitions, target_rir, exercise_order)
VALUES
((SELECT id FROM workout_program WHERE name = 'Transaction Test'), 12, 3, 10, 2, 1),
((SELECT id FROM workout_program WHERE name = 'Transaction Test'), 3, 3, 8, 2, 2);

COMMIT;

-- Transaction 2: The same operation, but the second exercise has sets = 0. 
-- This violates CHECK (sets > 0), so the whole transaction is rolled back
-- and the new program is not saved. 

BEGIN;

INSERT INTO program_exercise (program_id, exercise_id, sets, repetitions, target_rir, exercise_order)
VALUES
((SELECT id FROM workout_program WHERE name = 'Transaction Fail Test'), 12, 3, 10, 2, 1),
((SELECT id FROM workout_program WHERE name = 'Transaction Fail Test'), 3, 0, 8, 2, 2);

ROLLBACK;

-- Clean up the test data from transaction 1. 

DELETE FROM program_exercise
WHERE program_id = (SELECT id FROM workout_program WHERE name = 'Transaction Test');

DELETE FROM workout_program WHERE name = 'Transaction Test';