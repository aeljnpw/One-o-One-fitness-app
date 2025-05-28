/*
  # Add equipment and exercises sample data
  
  1. Data Changes
    - Add 5 pieces of equipment with proper images
    - Add 5 exercises with detailed instructions
    - All using proper UUID format
  
  2. Content
    - Equipment: Smith Machine, Adjustable Bench, Cable Machine, Leg Press, Lat Pulldown
    - Exercises: Various compound and isolation movements
    - Includes proper form instructions and tips
*/

-- Insert equipment data
INSERT INTO equipment (id, name, type, image_url) VALUES
  ('11111111-1111-1111-1111-111111111111', 'Smith Machine', 'Machine', 'https://images.pexels.com/photos/4164761/pexels-photo-4164761.jpeg'),
  ('22222222-2222-2222-2222-222222222222', 'Adjustable Bench', 'Bench', 'https://images.pexels.com/photos/4162485/pexels-photo-4162485.jpeg'),
  ('33333333-3333-3333-3333-333333333333', 'Cable Machine', 'Machine', 'https://images.pexels.com/photos/4162451/pexels-photo-4162451.jpeg'),
  ('44444444-4444-4444-4444-444444444444', 'Leg Press Machine', 'Machine', 'https://images.pexels.com/photos/4162456/pexels-photo-4162456.jpeg'),
  ('55555555-5555-5555-5555-555555555555', 'Lat Pulldown Machine', 'Machine', 'https://images.pexels.com/photos/4162487/pexels-photo-4162487.jpeg');

-- Insert exercises data
INSERT INTO exercises (
  id, equipment_id, title, video_url, instructions, tips,
  difficulty, duration, primary_muscles, secondary_muscles
) VALUES
  (
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    '11111111-1111-1111-1111-111111111111',
    'Smith Machine Squat',
    'https://example.com/videos/smith-machine-squat',
    ARRAY[
      'Stand with feet shoulder-width apart under the bar',
      'Position the bar across your upper back',
      'Unrack the bar and step back slightly',
      'Lower your body by bending your knees and hips',
      'Keep your chest up and back straight',
      'Push through your heels to return to starting position'
    ],
    ARRAY[
      'Keep your core tight throughout the movement',
      'Don''t let your knees cave inward',
      'Maintain a neutral spine position'
    ],
    'Intermediate',
    45,
    ARRAY['Quadriceps', 'Glutes', 'Hamstrings'],
    ARRAY['Core', 'Lower Back']
  ),
  (
    'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
    '22222222-2222-2222-2222-222222222222',
    'Incline Dumbbell Press',
    'https://example.com/videos/incline-press',
    ARRAY[
      'Set bench to 30-45 degree angle',
      'Lie back with feet flat on the floor',
      'Hold dumbbells at shoulder level',
      'Press weights up until arms are extended',
      'Lower weights back to starting position'
    ],
    ARRAY[
      'Keep your back pressed against the bench',
      'Don''t lock your elbows at the top',
      'Control the weight throughout the movement'
    ],
    'Intermediate',
    30,
    ARRAY['Upper Chest', 'Shoulders', 'Triceps'],
    ARRAY['Front Deltoids', 'Core']
  ),
  (
    'cccccccc-cccc-cccc-cccc-cccccccccccc',
    '33333333-3333-3333-3333-333333333333',
    'Cable Tricep Pushdown',
    'https://example.com/videos/tricep-pushdown',
    ARRAY[
      'Attach straight bar to high pulley',
      'Grab bar with overhand grip',
      'Keep elbows at sides',
      'Push bar down until arms are fully extended',
      'Slowly return to starting position'
    ],
    ARRAY[
      'Keep your upper arms stationary',
      'Don''t let your elbows move forward',
      'Focus on squeezing your triceps'
    ],
    'Beginner',
    20,
    ARRAY['Triceps'],
    ARRAY['Forearms', 'Shoulders']
  ),
  (
    'dddddddd-dddd-dddd-dddd-dddddddddddd',
    '44444444-4444-4444-4444-444444444444',
    'Leg Press',
    'https://example.com/videos/leg-press',
    ARRAY[
      'Sit in machine with back against pad',
      'Place feet shoulder-width apart on platform',
      'Lower weight by bending knees',
      'Push through heels to extend legs',
      'Don''t lock knees at top of movement'
    ],
    ARRAY[
      'Keep your lower back pressed against the pad',
      'Don''t let your knees cave inward',
      'Breathe steadily throughout the movement'
    ],
    'Intermediate',
    40,
    ARRAY['Quadriceps', 'Glutes'],
    ARRAY['Hamstrings', 'Calves']
  ),
  (
    'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee',
    '55555555-5555-5555-5555-555555555555',
    'Lat Pulldown',
    'https://example.com/videos/lat-pulldown',
    ARRAY[
      'Sit at machine with thighs under pad',
      'Grab bar with wide overhand grip',
      'Pull bar down to upper chest',
      'Squeeze shoulder blades together',
      'Slowly return to starting position'
    ],
    ARRAY[
      'Keep your chest up throughout movement',
      'Don''t lean back excessively',
      'Focus on using your back muscles, not arms'
    ],
    'Beginner',
    30,
    ARRAY['Latissimus Dorsi', 'Upper Back'],
    ARRAY['Biceps', 'Rear Deltoids']
  );