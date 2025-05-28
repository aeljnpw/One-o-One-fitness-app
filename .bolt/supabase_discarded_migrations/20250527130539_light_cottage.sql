/*
  # Add exercises with proper UUIDs

  1. Changes
    - Enable uuid-ossp extension if not already enabled
    - Add new exercises with properly generated UUIDs using uuid_generate_v4()
    - Each exercise has detailed instructions and proper muscle group targeting
*/

-- Enable the uuid-ossp extension if it's not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Insert new exercises with proper UUIDs
INSERT INTO exercises (
  id,
  equipment_id,
  title,
  instructions,
  tips,
  difficulty,
  duration,
  primary_muscles,
  secondary_muscles
) VALUES
(
  uuid_generate_v4(),
  (SELECT id FROM equipment WHERE name = 'Smith Machine' LIMIT 1),
  'Smith Machine Squat',
  ARRAY[
    'Position yourself under the bar with feet shoulder-width apart',
    'Unrack the bar and rest it across your upper back',
    'Lower your body by bending your knees and hips',
    'Keep your chest up and back straight',
    'Push through your heels to return to starting position'
  ],
  ARRAY[
    'Maintain proper form throughout the movement',
    'Keep your core engaged',
    'Don''t let your knees cave inward'
  ],
  'Intermediate',
  15,
  ARRAY['Quadriceps', 'Glutes'],
  ARRAY['Hamstrings', 'Calves']
),
(
  uuid_generate_v4(),
  (SELECT id FROM equipment WHERE name = 'Adjustable Bench' LIMIT 1),
  'Incline Dumbbell Press',
  ARRAY[
    'Set bench to 30-45 degree angle',
    'Lie back on the bench with feet flat on the floor',
    'Hold dumbbells at shoulder level',
    'Press weights up until arms are extended',
    'Lower weights back to starting position'
  ],
  ARRAY[
    'Keep your back pressed against the bench',
    'Don''t arch your lower back',
    'Control the weight throughout the movement'
  ],
  'Intermediate',
  12,
  ARRAY['Upper Chest', 'Shoulders'],
  ARRAY['Triceps']
),
(
  uuid_generate_v4(),
  (SELECT id FROM equipment WHERE name = 'Cable Machine' LIMIT 1),
  'Cable Face Pull',
  ARRAY[
    'Set cable at upper chest height',
    'Grab rope attachment with both hands',
    'Pull towards face, separating hands at the end',
    'Squeeze shoulder blades together',
    'Return to starting position with control'
  ],
  ARRAY[
    'Keep elbows high throughout movement',
    'Focus on rear deltoid contraction',
    'Maintain upright posture'
  ],
  'Beginner',
  10,
  ARRAY['Rear Deltoids', 'Upper Back'],
  ARRAY['Middle Trapezius', 'Rhomboids']
);