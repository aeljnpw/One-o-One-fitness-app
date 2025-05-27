/*
  # Initial Schema Setup for FitFlow Gym App

  1. New Tables
    - `equipment`
      - `id` (uuid, primary key)
      - `name` (text)
      - `type` (text)
      - `image_url` (text)
      - `created_at` (timestamp)
    
    - `exercises`
      - `id` (uuid, primary key)
      - `equipment_id` (uuid, foreign key)
      - `title` (text)
      - `video_url` (text)
      - `instructions` (text[])
      - `tips` (text[])
      - `difficulty` (text)
      - `duration` (integer)
      - `primary_muscles` (text[])
      - `secondary_muscles` (text[])
      - `created_at` (timestamp)
    
    - `workout_logs`
      - `id` (uuid, primary key)
      - `user_id` (uuid, foreign key)
      - `exercise_id` (uuid, foreign key)
      - `date` (timestamp)
      - `reps` (integer)
      - `sets` (integer)
      - `weight` (numeric)
      - `notes` (text)
      - `created_at` (timestamp)
    
    - `favorites`
      - `id` (uuid, primary key)
      - `user_id` (uuid, foreign key)
      - `exercise_id` (uuid, foreign key)
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users
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

-- Create workout_logs table
CREATE TABLE IF NOT EXISTS workout_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id),
  exercise_id uuid REFERENCES exercises(id),
  date timestamptz DEFAULT now(),
  reps integer DEFAULT 0,
  sets integer DEFAULT 0,
  weight numeric DEFAULT 0,
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now()
);

-- Create favorites table
CREATE TABLE IF NOT EXISTS favorites (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id),
  exercise_id uuid REFERENCES exercises(id),
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, exercise_id)
);

-- Enable Row Level Security
ALTER TABLE equipment ENABLE ROW LEVEL SECURITY;
ALTER TABLE exercises ENABLE ROW LEVEL SECURITY;
ALTER TABLE workout_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;

-- Equipment policies
CREATE POLICY "Equipment is viewable by everyone"
  ON equipment
  FOR SELECT
  TO public
  USING (true);

-- Exercise policies
CREATE POLICY "Exercises are viewable by everyone"
  ON exercises
  FOR SELECT
  TO public
  USING (true);

-- Workout log policies
CREATE POLICY "Users can view their own workout logs"
  ON workout_logs
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own workout logs"
  ON workout_logs
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own workout logs"
  ON workout_logs
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Favorites policies
CREATE POLICY "Users can view their own favorites"
  ON favorites
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own favorites"
  ON favorites
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own favorites"
  ON favorites
  FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);