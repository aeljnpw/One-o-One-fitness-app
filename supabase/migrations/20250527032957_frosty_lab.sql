/*
  # Equipment and Exercises Schema

  1. New Tables
    - equipment: Stores gym equipment information
    - exercises: Stores exercise details for each piece of equipment

  2. Security
    - Enable RLS on both tables
    - Add policies for public read access

  3. Data
    - Insert initial equipment data
    - Insert sample exercise data
*/

-- Create equipment table
CREATE TABLE IF NOT EXISTS equipment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  type text NOT NULL,
  image_url text,
  created_at timestamptz DEFAULT now()
);

-- Create exercises table
CREATE TABLE IF NOT EXISTS exercises (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  equipment_id uuid REFERENCES equipment(id),
  title text NOT NULL,
  video_url text,
  instructions text[] DEFAULT '{}',
  tips text[] DEFAULT '{}',
  difficulty text NOT NULL,
  duration integer DEFAULT 0,
  primary_muscles text[] DEFAULT '{}',
  secondary_muscles text[] DEFAULT '{}',
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE equipment ENABLE ROW LEVEL SECURITY;
ALTER TABLE exercises ENABLE ROW LEVEL SECURITY;

-- Create policies (with safety checks)
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies 
    WHERE tablename = 'equipment' 
    AND policyname = 'Equipment is viewable by everyone'
  ) THEN
    CREATE POLICY "Equipment is viewable by everyone" ON equipment
      FOR SELECT TO public USING (true);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies 
    WHERE tablename = 'exercises' 
    AND policyname = 'Exercises are viewable by everyone'
  ) THEN
    CREATE POLICY "Exercises are viewable by everyone" ON exercises
      FOR SELECT TO public USING (true);
  END IF;
END $$;

-- Insert equipment data
INSERT INTO equipment (name, type, image_url) VALUES
  ('PEC FLY / REAR DELT', 'Machine', 'https://images.pexels.com/photos/4162485/pexels-photo-4162485.jpeg'),
  ('LAT PULL / SEATED ROW', 'Machine', 'https://images.pexels.com/photos/4162529/pexels-photo-4162529.jpeg'),
  ('LEG EXTENSION / LEG CURL', 'Machine', 'https://images.pexels.com/photos/4162538/pexels-photo-4162538.jpeg'),
  ('SEATED PREACHER CURL', 'Machine', 'https://images.pexels.com/photos/4162451/pexels-photo-4162451.jpeg'),
  ('SEATED CALF RAISE', 'Machine', 'https://images.pexels.com/photos/4162579/pexels-photo-4162579.jpeg'),
  ('FLAT BENCH', 'Bench', 'https://images.pexels.com/photos/4397840/pexels-photo-4397840.jpeg'),
  ('MULTI ADJUSTABLE BENCH', 'Bench', 'https://images.pexels.com/photos/4162581/pexels-photo-4162581.jpeg'),
  ('MULTI HYPER EXTENSION', 'Machine', 'https://images.pexels.com/photos/6550851/pexels-photo-6550851.jpeg'),
  ('DECLINE BENCH', 'Bench', 'https://images.pexels.com/photos/6550861/pexels-photo-6550861.jpeg'),
  ('INCLINE BENCH', 'Bench', 'https://images.pexels.com/photos/4164761/pexels-photo-4164761.jpeg'),
  ('UTILITY BENCH', 'Bench', 'https://images.pexels.com/photos/4162488/pexels-photo-4162488.jpeg'),
  ('MULTI PRESS', 'Machine', 'https://images.pexels.com/photos/4162493/pexels-photo-4162493.jpeg'),
  ('FUNCTIONAL TRAINER', 'Machine', 'https://images.pexels.com/photos/4162497/pexels-photo-4162497.jpeg'),
  ('SMITH SQUAT COMBO', 'Machine', 'https://images.pexels.com/photos/4162503/pexels-photo-4162503.jpeg'),
  ('HYPER EXTENSION', 'Machine', 'https://images.pexels.com/photos/4162508/pexels-photo-4162508.jpeg'),
  ('LEG PRESS', 'Machine', 'https://images.pexels.com/photos/4162513/pexels-photo-4162513.jpeg'),
  ('ABDOMINAL', 'Machine', 'https://images.pexels.com/photos/4162518/pexels-photo-4162518.jpeg'),
  ('ROW', 'Machine', 'https://images.pexels.com/photos/4162523/pexels-photo-4162523.jpeg'),
  ('CHEST PRESS / LAT PULLDOWN', 'Machine', 'https://images.pexels.com/photos/4162533/pexels-photo-4162533.jpeg'),
  ('SQUAT PLATFORM', 'Machine', 'https://images.pexels.com/photos/4162543/pexels-photo-4162543.jpeg'),
  ('SISSY SQUAT', 'Machine', 'https://images.pexels.com/photos/4162548/pexels-photo-4162548.jpeg'),
  ('DUAL TWISTER', 'Machine', 'https://images.pexels.com/photos/4162553/pexels-photo-4162553.jpeg')
ON CONFLICT (id) DO NOTHING;

-- Insert sample exercise data for PEC FLY / REAR DELT
INSERT INTO exercises (equipment_id, title, instructions, tips, difficulty, primary_muscles, secondary_muscles)
SELECT 
  id,
  'Pec Deck Fly',
  ARRAY[
    'Adjust seat height so handles align with mid-chest level',
    'Sit upright, back flat against pad, feet flat on floor',
    'Grasp handles with elbows slightly bent',
    'Exhale and bring handles together in front of chest, squeezing pecs',
    'Inhale and allow handles to slowly return to start with control'
  ],
  ARRAY[
    'Don''t let elbows drop below shoulder line',
    'Use a weight you can control through full range',
    'Keep spine neutral—no overarching or slumping'
  ],
  'Intermediate',
  ARRAY['Chest', 'Pectoralis Major'],
  ARRAY['Front Deltoids', 'Biceps']
FROM equipment
WHERE name = 'PEC FLY / REAR DELT'
ON CONFLICT (id) DO NOTHING;