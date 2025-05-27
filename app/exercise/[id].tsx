import { View, Text, StyleSheet, ScrollView, TouchableOpacity, ActivityIndicator } from 'react-native';
import { useLocalSearchParams, Stack, useRouter } from 'expo-router';
import { ChevronLeft } from 'lucide-react-native';
import { useEffect, useState } from 'react';
import { supabase } from '@/lib/supabase';

type Exercise = {
  id: string;
  title: string;
  video_url: string | null;
  instructions: string[];
  tips: string[];
  difficulty: string;
  duration: number;
  primary_muscles: string[];
  secondary_muscles: string[];
};

export default function ExerciseDetail() {
  const { id } = useLocalSearchParams();
  const router = useRouter();
  const [exercise, setExercise] = useState<Exercise | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetchExerciseDetails();
  }, [id]);

  async function fetchExerciseDetails() {
    try {
      setLoading(true);
      const { data, error: fetchError } = await supabase
        .from('exercises')
        .select('*')
        .eq('id', id)
        .single();

      if (fetchError) throw fetchError;
      setExercise(data);
      setError(null);
    } catch (err) {
      setError('Failed to load exercise details. Please try again.');
      console.error('Error:', err);
    } finally {
      setLoading(false);
    }
  }

  if (loading) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color="#3b82f6" />
      </View>
    );
  }

  if (error || !exercise) {
    return (
      <View style={styles.errorContainer}>
        <Text style={styles.errorText}>{error || 'Exercise not found'}</Text>
        <TouchableOpacity
          style={styles.retryButton}
          onPress={fetchExerciseDetails}>
          <Text style={styles.retryButtonText}>Retry</Text>
        </TouchableOpacity>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <Stack.Screen
        options={{
          headerShown: true,
          header: () => (
            <View style={styles.header}>
              <TouchableOpacity
                style={styles.backButton}
                onPress={() => router.back()}>
                <ChevronLeft size={24} color="#18181b" />
              </TouchableOpacity>
              <Text style={styles.headerTitle}>{exercise.title}</Text>
            </View>
          ),
        }}
      />

      <ScrollView style={styles.content}>
        <View style={styles.videoPlaceholder}>
          <Text style={styles.placeholderText}>
            {exercise.video_url ? 'Video will be displayed here' : 'Video coming soon'}
          </Text>
        </View>

        <View style={styles.exerciseInfo}>
          <View style={styles.difficultyDuration}>
            <Text style={styles.difficulty}>{exercise.difficulty}</Text>
            <Text style={styles.duration}>{exercise.duration} min</Text>
          </View>

          <View style={styles.muscleGroups}>
            <View>
              <Text style={styles.muscleGroupTitle}>Primary Muscles</Text>
              <View style={styles.muscleTagContainer}>
                {exercise.primary_muscles.map((muscle, index) => (
                  <View key={index} style={styles.muscleTag}>
                    <Text style={styles.muscleTagText}>{muscle}</Text>
                  </View>
                ))}
              </View>
            </View>

            <View style={styles.secondaryMuscles}>
              <Text style={styles.muscleGroupTitle}>Secondary Muscles</Text>
              <View style={styles.muscleTagContainer}>
                {exercise.secondary_muscles.map((muscle, index) => (
                  <View key={index} style={[styles.muscleTag, styles.secondaryMuscleTag]}>
                    <Text style={[styles.muscleTagText, styles.secondaryMuscleTagText]}>{muscle}</Text>
                  </View>
                ))}
              </View>
            </View>
          </View>
        </View>

        <View style={styles.section}>
          <Text style={styles.sectionTitle}>How to Do</Text>
          {exercise.instructions.map((instruction, index) => (
            <View key={index} style={styles.listItem}>
              <Text style={styles.bulletPoint}>•</Text>
              <Text style={styles.listText}>{instruction}</Text>
            </View>
          ))}
        </View>

        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Tips</Text>
          {exercise.tips.map((tip, index) => (
            <View key={index} style={styles.listItem}>
              <Text style={styles.bulletPoint}>•</Text>
              <Text style={styles.listText}>{tip}</Text>
            </View>
          ))}
        </View>
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ffffff',
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#ffffff',
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
    backgroundColor: '#ffffff',
  },
  errorText: {
    fontSize: 16,
    color: '#ef4444',
    textAlign: 'center',
    marginBottom: 12,
    fontFamily: 'Inter-Regular',
  },
  retryButton: {
    backgroundColor: '#3b82f6',
    paddingHorizontal: 20,
    paddingVertical: 10,
    borderRadius: 8,
  },
  retryButtonText: {
    color: '#ffffff',
    fontSize: 16,
    fontFamily: 'Inter-SemiBold',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingTop: 60,
    paddingHorizontal: 16,
    paddingBottom: 16,
    backgroundColor: '#ffffff',
    borderBottomWidth: 1,
    borderBottomColor: '#f4f4f5',
  },
  backButton: {
    padding: 8,
    marginRight: 8,
  },
  headerTitle: {
    flex: 1,
    fontSize: 20,
    fontFamily: 'Inter-SemiBold',
    color: '#18181b',
  },
  content: {
    flex: 1,
  },
  videoPlaceholder: {
    height: 240,
    backgroundColor: '#f4f4f5',
    justifyContent: 'center',
    alignItems: 'center',
  },
  placeholderText: {
    fontSize: 16,
    color: '#71717a',
    fontFamily: 'Inter-Regular',
  },
  exerciseInfo: {
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f4f4f5',
  },
  difficultyDuration: {
    flexDirection: 'row',
    marginBottom: 16,
  },
  difficulty: {
    fontSize: 16,
    fontFamily: 'Inter-SemiBold',
    color: '#3b82f6',
    marginRight: 16,
  },
  duration: {
    fontSize: 16,
    fontFamily: 'Inter-Regular',
    color: '#71717a',
  },
  muscleGroups: {
    gap: 16,
  },
  muscleGroupTitle: {
    fontSize: 14,
    fontFamily: 'Inter-SemiBold',
    color: '#18181b',
    marginBottom: 8,
  },
  muscleTagContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  muscleTag: {
    backgroundColor: '#e0e7ff',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 16,
  },
  muscleTagText: {
    fontSize: 14,
    fontFamily: 'Inter-Regular',
    color: '#4f46e5',
  },
  secondaryMuscles: {
    marginTop: 16,
  },
  secondaryMuscleTag: {
    backgroundColor: '#f1f5f9',
  },
  secondaryMuscleTagText: {
    color: '#64748b',
  },
  section: {
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f4f4f5',
  },
  sectionTitle: {
    fontSize: 20,
    fontFamily: 'Inter-Bold',
    color: '#18181b',
    marginBottom: 16,
  },
  listItem: {
    flexDirection: 'row',
    marginBottom: 12,
  },
  bulletPoint: {
    fontSize: 16,
    color: '#71717a',
    marginRight: 8,
  },
  listText: {
    flex: 1,
    fontSize: 16,
    fontFamily: 'Inter-Regular',
    color: '#18181b',
    lineHeight: 24,
  },
});