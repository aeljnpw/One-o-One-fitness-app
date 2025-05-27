/*
  # Add Additional Exercises

  1. New Exercises
    - Flat Bench Press (for Adjustable Bench)
    - Standing Cable Fly (for Cable Machine)
    - Smith Machine Deadlift (for Smith Machine)
    - Seated Leg Extension (for Leg Press Machine)
    - Wide-Grip Pulldown (for Lat Pulldown Machine)

  Each exercise includes:
    - Detailed instructions
    - Helpful tips
    - Difficulty level
    - Duration
    - Primary and secondary muscle groups
*/

INSERT INTO exercises (
  id, equipment_id, title, video_url, instructions, tips,
  difficulty, duration, primary_muscles, secondary_muscles
) VALUES
  (
    'a1b2c3d4-e5f6-47g8-9h0i-j1k2l3m4n5o6',
    '22222222-2222-2222-2222-222222222222',
    'Flat Bench Press',
    'https://example.com/videos/bench-press',
    ARRAY[
      'Lie flat on the bench with feet planted firmly on the ground',
      'Grip the barbell slightly wider than shoulder width',
      'Lower the bar to your mid-chest',
      'Press the bar up in a controlled motion',
      'Keep your wrists straight and elbows tucked'
    ],
    ARRAY[
      'Maintain a slight arch in your lower back',
      'Keep your shoulder blades pinched together',
      'Breathe out on the push, in on the descent'
    ],
    'Intermediate',
    35,
    ARRAY['Chest', 'Triceps'],
    ARRAY['Front Deltoids', 'Core']
  ),
  (
    'b2c3d4e5-f6g7-48h9-0i1j-k2l3m4n5o6p7',
    '33333333-3333-3333-3333-333333333333',
    'Standing Cable Fly',
    'https://example.com/videos/cable-fly',
    ARRAY[
      'Set cable pulleys to chest height',
      'Stand in the center with feet shoulder-width apart',
      'Keep a slight bend in your elbows',
      'Bring handles together in front of your chest',
      'Slowly return to starting position with controlled movement'
    ],
    ARRAY[
      'Maintain tension throughout the movement',
      'Keep your core engaged',
      'Don''t let the weights pull your arms back too far'
    ],
    'Intermediate',
    25,
    ARRAY['Chest', 'Front Deltoids'],
    ARRAY['Biceps', 'Core']
  ),
  (
    'c3d4e5f6-g7h8-49i0-1j2k-l3m4n5o6p7q8',
    '11111111-1111-1111-1111-111111111111',
    'Smith Machine Deadlift',
    'https://example.com/videos/smith-deadlift',
    ARRAY[
      'Position feet shoulder-width apart',
      'Bend at hips and knees to grasp the bar',
      'Keep your back straight and chest up',
      'Drive through your heels as you stand',
      'Return the weight in a controlled manner'
    ],
    ARRAY[
      'Keep the bar close to your body',
      'Engage your lats before lifting',
      'Don''t round your back'
    ],
    'Advanced',
    40,
    ARRAY['Lower Back', 'Hamstrings', 'Glutes'],
    ARRAY['Quadriceps', 'Core', 'Trapezius']
  ),
  (
    'd4e5f6g7-h8i9-50j1-2k3l-m4n5o6p7q8r9',
    '44444444-4444-4444-4444-444444444444',
    'Seated Leg Extension',
    'https://example.com/videos/leg-extension',
    ARRAY[
      'Adjust seat position so knees align with pivot point',
      'Position feet behind ankle pad',
      'Grasp handles for stability',
      'Extend legs fully without locking knees',
      'Lower weight slowly back to starting position'
    ],
    ARRAY[
      'Don''t swing or use momentum',
      'Keep your back against the pad',
      'Focus on squeezing your quadriceps'
    ],
    'Beginner',
    20,
    ARRAY['Quadriceps'],
    ARRAY['Knee Stabilizers']
  ),
  (
    'e5f6g7h8-i9j0-51k2-3l4m-n5o6p7q8r9s0',
    '55555555-5555-5555-5555-555555555555',
    'Wide-Grip Pulldown',
    'https://example.com/videos/wide-grip-pulldown',
    ARRAY[
      'Grip the bar wider than shoulder width',
      'Lean back slightly',
      'Pull the bar to your upper chest',
      'Focus on using your back muscles',
      'Control the weight on the return'
    ],
    ARRAY[
      'Keep your chest up and shoulders back',
      'Initiate the movement with your lats',
      'Avoid excessive backward lean'
    ],
    'Intermediate',
    30,
    ARRAY['Latissimus Dorsi', 'Rhomboids'],
    ARRAY['Biceps', 'Rear Deltoids', 'Trapezius']
  );