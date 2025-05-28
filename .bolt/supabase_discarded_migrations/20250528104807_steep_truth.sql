/*
  # Remove unwanted equipment data

  1. Changes
    - Remove Smith Machine equipment entry
    - Remove any associated exercises
*/

DO $$ 
BEGIN
  -- Delete exercises linked to Smith Machine first
  DELETE FROM exercises 
  WHERE equipment_id IN (
    SELECT id FROM equipment WHERE name = 'Smith Machine'
  );
  
  -- Then delete the Smith Machine equipment
  DELETE FROM equipment 
  WHERE name = 'Smith Machine';
END $$;