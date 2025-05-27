/*
  # Add equipment and exercises data

  1. Data Population
    - Add realistic gym equipment data
    - Add detailed exercises for each equipment
    - Include proper descriptions, instructions, and muscle groups

  2. Equipment Categories
    - Machines
    - Free Weights
    - Benches
    - Cardio Equipment

  3. Exercise Details
    - Complete instructions
    - Proper form tips
    - Target muscle groups
    - Difficulty levels
    - Estimated durations
*/

-- Insert equipment data
INSERT INTO equipment (id, name, type, image_url) VALUES
  ('e001', 'Smith Machine', 'Machine', 'https://images.pexels.com/photos/4164761/pexels-photo-4164761.jpeg'),
  ('e002', 'Adjustable Bench', 'Bench', 'https://images.pexels.com/photos/4162485/pexels-photo-4162485.jpeg'),
  ('e003', 'Cable Machine', 'Machine', 'https://images.pexels.com/photos/4162451/pexels-photo-4162451.jpeg'),
  ('e004', 'Leg Press Machine', 'Machine', 'https://images.pexels.com/photos/4162456/pexels-photo-4162456.jpeg'),
  ('e005', 'Lat Pulldown Machine', 'Machine', 'https://images.pexels.com/photos/4162487/pexels-photo-4162487.jpeg');

-- Insert exercises data
INSERT INTO exercises (
  id, equipment_id, title, video_url, instructions, tips,
  difficulty, duration, primary_muscles, secondary_muscles
) VALUES
  (
    'ex001',
    'e001',
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
    'ex002',
    'e002',
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
    'ex003',
    'e003',
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
    'ex004',
    'e004',
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
    'ex005',
    'e005',
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