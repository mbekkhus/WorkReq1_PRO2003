-- Demonstrates inserting, updating, and deleting a user account.
-- The temporary user has no workout programs, so it can be deleted without violating foreign-key relationships.

-- Insert a temporary user.
INSERT INTO app_user (name, email)
VALUES ('Temporary User', 'temporary@example.com');

-- Update the temporary user's information.
UPDATE app_user
SET
  name = 'Updated Temporary User',
  email = 'updated.temporary@example.com'
WHERE email = 'temporary@example.com';

-- Delete the temporary user.
DELETE FROM app_user
WHERE email = 'updated.temporary@example.com';