/*
  # Insert equipment and exercises data
  
  1. Data Population
    - Add initial equipment entries
    - Add corresponding exercises for each piece of equipment
  
  2. Data Structure
    - Equipment: Basic info and image URLs
    - Exercises: Detailed workout information including instructions and muscle groups
*/

-- Insert equipment data
INSERT INTO equipment (id, name, type, image_url) VALUES
  ('98f0c3b7-7247-4c46-a8f1-8be42644974b', 'Smith Machine', 'Machine', 'https://images.pexels.com/photos/4164761/pexels-photo-4164761.jpeg'),
  ('b2d3f8a1-9e56-4c12-b5d4-3f89e5c7a6d2', 'Adjustable Bench', 'Bench', 'https://images.pexels.com/photos/4162485/pexels-photo-4162485.jpeg'),
  ('c4e5d6f7-8901-2345-6789-0abc1def2345', 'Cable Machine', 'Machine', 'https://images.pexels.com/photos/4162451/pexels-photo-4162451.jpeg'),
  ('d5e6f7a8-9012-3456-7890-1bcd2ef34567', 'Leg Press Machine', 'Machine', 'https://images.pexels.com/photos/4162456/pexels-photo-4162456.jpeg'),
  ('e6f7a8b9-0123-4567-8901-2cde3f456789', 'Lat Pulldown Machine', 'Machine', 'https://images.pexels.com/photos/4162487/pexels-photo-4162487.jpeg');

-- Insert exercises data
INSERT INTO exercises (
  id, equipment_id, title, video_url, instructions, tips,
  difficulty, duration, primary_muscles, secondary_muscles
) VALUES
  (
    'f7a8b9c0-1234-5678-9012-3def45678901',
    '98f0c3b7-7247-4c46-a8f1-8be42644974b',
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
    'a8b9c0d1-2345-6789-0123-4ef56789012',
    'b2d3f8a1-9e56-4c12-b5d4-3f89e5c7a6d2',
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
    'b9c0d1e2-3456-7890-1234-5ef67890123',
    'c4e5d6f7-8901-2345-6789-0abc1def2345',
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
    'c0d1e2f3-4567-8901-2345-6ef78901234',
    'd5e6f7a8-9012-3456-7890-1bcd2ef34567',
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
    'd1e2f3a4-5678-9012-3456-7ef89012345',
    'e6f7a8b9-0123-4567-8901-2cde3f456789',
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