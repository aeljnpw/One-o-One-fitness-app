/*
  # Add More Exercises

  1. Changes
    - Add additional exercises for existing equipment
    - Each exercise includes complete instructions, tips, and muscle group information
    - All exercises are linked to existing equipment IDs
*/

-- Insert additional exercises
INSERT INTO exercises (
  id, equipment_id, title, video_url, instructions, tips,
  difficulty, duration, primary_muscles, secondary_muscles
) VALUES
  (
    'e2f3a4b5-6789-0123-4567-8ef90123456',
    '98f0c3b7-7247-4c46-a8f1-8be42644974b', -- Smith Machine
    'Smith Machine Bench Press',
    'https://example.com/videos/smith-bench-press',
    ARRAY[
      'Lie flat on bench with feet planted firmly',
      'Grip the bar slightly wider than shoulder width',
      'Unrack the bar and lower it to your chest',
      'Press the bar up in a controlled motion',
      'Keep wrists straight throughout movement'
    ],
    ARRAY[
      'Maintain full body tension',
      'Keep your shoulder blades retracted',
      'Don''t bounce the bar off your chest'
    ],
    'Intermediate',
    35,
    ARRAY['Chest', 'Shoulders', 'Triceps'],
    ARRAY['Core', 'Front Deltoids']
  ),
  (
    'f3a4b5c6-7890-1234-5678-9ef01234567',
    'b2d3f8a1-9e56-4c12-b5d4-3f89e5c7a6d2', -- Adjustable Bench
    'Dumbbell Row',
    'https://example.com/videos/dumbbell-row',
    ARRAY[
      'Place knee and hand on bench for support',
      'Keep back parallel to ground',
      'Pull dumbbell to hip level',
      'Lower weight with control',
      'Maintain neutral spine position'
    ],
    ARRAY[
      'Keep your core engaged',
      'Squeeze your back at the top',
      'Avoid rotating your torso'
    ],
    'Beginner',
    25,
    ARRAY['Upper Back', 'Latissimus Dorsi'],
    ARRAY['Biceps', 'Rear Deltoids']
  ),
  (
    'a4b5c6d7-8901-2345-6789-0ef12345678',
    'c4e5d6f7-8901-2345-6789-0abc1def2345', -- Cable Machine
    'Cable Face Pull',
    'https://example.com/videos/face-pull',
    ARRAY[
      'Attach rope attachment to high pulley',
      'Pull rope towards face with elbows high',
      'Focus on squeezing shoulder blades',
      'Control the weight on return',
      'Keep upper arms parallel to ground'
    ],
    ARRAY[
      'Lead with your elbows',
      'Keep your shoulders down',
      'Maintain upright posture'
    ],
    'Beginner',
    20,
    ARRAY['Rear Deltoids', 'Upper Back'],
    ARRAY['Rotator Cuff', 'Middle Trapezius']
  ),
  (
    'b5c6d7e8-9012-3456-7890-1ef23456789',
    'd5e6f7a8-9012-3456-7890-1bcd2ef34567', -- Leg Press
    'Calf Press',
    'https://example.com/videos/calf-press',
    ARRAY[
      'Position feet at bottom of platform',
      'Press through balls of feet',
      'Extend ankles fully',
      'Lower heels below platform level',
      'Maintain controlled movement'
    ],
    ARRAY[
      'Don''t rush the movement',
      'Feel the stretch at bottom',
      'Focus on full range of motion'
    ],
    'Beginner',
    15,
    ARRAY['Calves'],
    ARRAY['Tibialis Anterior']
  ),
  (
    'c6d7e8f9-0123-4567-8901-2ef34567890',
    'e6f7a8b9-0123-4567-8901-2cde3f456789', -- Lat Pulldown Machine
    'Close Grip Pulldown',
    'https://example.com/videos/close-grip-pulldown',
    ARRAY[
      'Attach V-bar handle to cable',
      'Grip handles with palms facing each other',
      'Pull bar to upper chest',
      'Keep elbows close to body',
      'Control the weight up'
    ],
    ARRAY[
      'Maintain strict form',
      'Avoid leaning back excessively',
      'Focus on lat engagement'
    ],
    'Intermediate',
    25,
    ARRAY['Latissimus Dorsi', 'Lower Trapezius'],
    ARRAY['Biceps', 'Forearms']
  );