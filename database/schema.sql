CREATE TABLE app_user (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE workout_program (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id INTEGER NOT NULL,
  name TEXT NOT NULL, 
  description TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES app_user(id)
);

CREATE TABLE exercise (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  muscle_group TEXT NOT NULL,
  description TEXT
);

CREATE TABLE program_exercise (
  program_id INTEGER NOT NULL,
  exercise_id INTEGER NOT NULL, 
  sets INTEGER NOT NULL CHECK (sets > 0),
  repetitions INTEGER NOT NULL CHECK (repetitions > 0),
  target_rir INTEGER CHECK (target_rir >= 0),
  exercise_order INTEGER NOT NULL CHECK (exercise_order > 0),
  PRIMARY KEY (program_id, exercise_id),
  FOREIGN KEY (program_id) REFERENCES workout_program(id),
  FOREIGN KEY (exercise_id) REFERENCES exercise(id),
  UNIQUE (program_id, exercise_order)
);