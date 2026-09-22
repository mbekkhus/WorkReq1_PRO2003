-- Test data for the strength training and progression platform.
-- Data must be inserted in an order that respects foreign-key relationships.

TRUNCATE TABLE
  program_exercise,
  workout_program,
  exercise,
  app_user
RESTART IDENTITY CASCADE;

INSERT INTO app_user (name, email)
VALUES
('Marte Bekkhus', 'marte@example.com'),
('Hillevi Knutsen', 'hillevi@example.com'),
('Oliver Berg', 'oliver@example.com'),
('Ada Johansen', 'ada@example.com');

INSERT INTO workout_program (user_id, name, description)
VALUES
  (1, 'Lower Body Strength', 'A strength-focused program for legs and glutes.'),
  (1, 'Upper Body Strength', 'A strength-focused program for the upper body.'),
  (2, 'Full Body Beginner', 'A beginner-friendly program covering the whole body.'),
  (3, 'Push and Pull Basics', 'A balanced program with basic push and pull exercises.'),
  (3, 'Glute Progression', 'A program focused on developing glute strength.');

INSERT INTO exercise (name, muscle_group, description)
VALUES
  ('Romanian Deadlift', 'Hamstrings', 'A hip-hinge exercise targeting the hamstrings and glutes.'),
  ('Hip Thrust', 'Glutes', 'A hip-extension exercise focused on the glutes.'),
  ('Hack Squat', 'Quadriceps', 'A machine-based squat variation targeting the lower body.'),
  ('Lat Pulldown - Wide Grip', 'Back', 'A vertical pulling exercise performed with a wide grip.'),
  ('Lat Pulldown - Close Grip', 'Back', 'A vertical pulling exercise performed with a close grip.'),
  ('Seated Cable Row - Wide Grip', 'Back', 'A horizontal pulling exercise performed with a wide grip.'),
  ('Seated Cable Row - Close Grip', 'Back', 'A horizontal pulling exercise performed with a close grip.'),
  ('Face Pull', 'Shoulders', 'A cable exercise targeting the rear shoulders and upper back.'),
  ('Biceps Curl', 'Biceps', 'An isolation exercise targeting the biceps.'),
  ('Triceps Pushdown', 'Triceps', 'A cable exercise targeting the triceps.'),
  ('Goblet Squat', 'Quadriceps', 'A squat variation performed while holding a weight in front of the body.'),
  ('Leg Press', 'Quadriceps', 'A machine exercise targeting the legs.'),
  ('Bulgarian Split Squat', 'Quadriceps', 'A single-leg squat variation targeting the legs and glutes.'),
  ('Back Extension', 'Lower Back', 'An exercise targeting the lower back and posterior chain.'),
  ('Chest Press', 'Chest', 'A pressing exercise targeting the chest and triceps.'),
  ('Shoulder Press', 'Shoulders', 'A vertical pressing exercise targeting the shoulders.'),
  ('Standing Calf Raise', 'Calves', 'An isolation exercise targeting the calf muscles.');

INSERT INTO program_exercise (
  program_id,
  exercise_id,
  sets,
  repetitions,
  target_rir,
  exercise_order
)

VALUES
  -- Program 1: Lower Body Strength
  (1, 3, 4, 8, 2, 1), -- Hack squat
  (1, 1, 4, 8, 2, 2), -- RDL
  (1, 2, 4, 10, 1, 3), -- Hip thrust
  (1, 12, 3, 12, 2, 4), -- Leg press 
  (1, 13, 3, 10, 2, 5), -- Bulgarian split squat
  (1, 14, 3, 12, 2, 6), -- Back extension

  -- Program 2: Upper Body Strength
  (2, 4, 3, 10, 2, 1), -- Lat pulldown, wide grip
  (2, 6, 3, 10, 2, 2), -- Seated cable row, wide grip
  (2, 15, 3, 10, 2, 3), -- Chest press
  (2, 16, 3, 10, 2, 4), -- Shoulder press
  (2, 8, 3, 12, 2, 5), -- Face pull
  (2, 9, 3, 12, 2, 6), -- Biceps curl
  (2, 10, 3, 12, 2, 7), -- Triceps pushdown 

    -- Program 3: Full Body Beginner
  (3, 11, 3, 10, 3, 1), -- Goblet squat
  (3, 2, 3, 12, 3, 2), -- Hip thrust
  (3, 5, 3, 10, 3, 3), -- Lat pulldown, close grip
  (3, 15, 3, 10, 3, 4), -- Chest press
  (3, 7, 3, 10, 3, 5), -- Seated cable row, close grip
  (3, 8, 2, 15, NULL, 6), -- Face pull

  -- Program 4: Push and Pull Basics
  (4, 15, 4, 8, 2, 1), -- Chest press
  (4, 16, 3, 10, 2, 2), -- Shoulder press
  (4, 10, 3, 12, 2, 3), -- Triceps pushdown
  (4, 4, 4, 8, 2, 4), -- Lat pulldown, wide grip
  (4, 6, 4, 8, 2, 5), -- Seated cable row, wide grip
  (4, 9, 3, 12, 2, 6), -- Biceps curl
  (4, 8, 3, 15, 3, 7), -- Face pull

  -- Program 5: Glute Progression
  (5, 2, 4, 8, 1, 1), -- Hip thrust
  (5, 1, 4, 10, 2, 2), -- RDL
  (5, 13, 3, 10, 2, 3), -- Bulgarian split squat
  (5, 3, 3, 10, 2, 4), -- Hack squat
  (5, 14, 3, 12, 2, 5), -- Back extension
  (5, 12, 3, 12, 2, 6); -- Leg press