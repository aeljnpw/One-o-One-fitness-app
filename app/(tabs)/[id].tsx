import { View, Text, StyleSheet, ScrollView, Image, TouchableOpacity, ActivityIndicator } from 'react-native';
import { useLocalSearchParams, Stack, useRouter } from 'expo-router';
import { ChevronLeft } from 'lucide-react-native';
import { useEffect, useState } from 'react';
import { supabase } from '@/lib/supabase';

type Equipment = {
  id: string;
  name: string;
  type: string;
  image_url: string;
};

type Exercise = {
  id: string;
  title: string;
  difficulty: string;
  duration: number;
  primary_muscles: string[];
  secondary_muscles: string[];
};

export default function EquipmentDetail() {
  const { id } = useLocalSearchParams();
  const router = useRouter();
  const [equipment, setEquipment] = useState<Equipment | null>(null);
  const [exercises, setExercises] = useState<Exercise[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetchEquipmentDetails();
  }, [id]);

  async function fetchEquipmentDetails() {
    try {
      setLoading(true);
      
      // Fetch equipment details
      const { data: equipmentData, error: equipmentError } = await supabase
        .from('equipment')
        .select('*')
        .eq('id', id)
        .single();

      if (equipmentError) throw equipmentError;
      setEquipment(equipmentData);

      // Fetch related exercises
      const { data: exercisesData, error: exercisesError } = await supabase
        .from('exercises')
        .select('id, title, difficulty, duration, primary_muscles, secondary_muscles')
        .eq('equipment_id', id);

      if (exercisesError) throw exercisesError;
      setExercises(exercisesData || []);
      setError(null);
    } catch (err) {
      setError('Failed to load equipment details. Please try again.');
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

  if (error || !equipment) {
    return (
      <View style={styles.errorContainer}>
        <Text style={styles.errorText}>{error || 'Equipment not found'}</Text>
        <TouchableOpacity
          style={styles.retryButton}
          onPress={fetchEquipmentDetails}>
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
              <Text style={styles.headerTitle}>{equipment.name}</Text>
            </View>
          ),
        }}
      />
      
      <ScrollView style={styles.content}>
        <Image source={{ uri: equipment.image_url }} style={styles.equipmentImage} />
        
        <View style={styles.infoSection}>
          <Text style={styles.sectionTitle}>About this Equipment</Text>
          <Text style={styles.equipmentType}>{equipment.type}</Text>
        </View>

        <View style={styles.exercisesSection}>
          <Text style={styles.sectionTitle}>Available Exercises</Text>
          {exercises.length === 0 ? (
            <Text style={styles.noExercisesText}>No exercises available for this equipment yet.</Text>
          ) : (
            exercises.map((exercise) => (
              <TouchableOpacity
                key={exercise.id}
                style={styles.exerciseCard}
                onPress={() => router.push(`/exercise/${exercise.id}`)}>
                <View>
                  <Text style={styles.exerciseName}>{exercise.title}</Text>
                  <Text style={styles.exerciseDetails}>
                    {exercise.difficulty} • {exercise.duration} min
                  </Text>
                </View>
                <View style={styles.muscleGroups}>
                  {exercise.primary_muscles.map((muscle, index) => (
                    <View key={index} style={styles.muscleTag}>
                      <Text style={styles.muscleTagText}>{muscle}</Text>
                    </View>
                  ))}
                </View>
              </TouchableOpacity>
            ))
          )}
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
  equipmentImage: {
    width: '100%',
    height: 300,
    resizeMode: 'cover',
  },
  infoSection: {
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f4f4f5',
  },
  sectionTitle: {
    fontSize: 20,
    fontFamily: 'Inter-Bold',
    color: '#18181b',
    marginBottom: 8,
  },
  equipmentType: {
    fontSize: 16,
    fontFamily: 'Inter-Regular',
    color: '#71717a',
  },
  exercisesSection: {
    padding: 16,
  },
  noExercisesText: {
    fontSize: 16,
    fontFamily: 'Inter-Regular',
    color: '#71717a',
    fontStyle: 'italic',
    textAlign: 'center',
    marginTop: 20,
  },
  exerciseCard: {
    backgroundColor: '#f4f4f5',
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
  },
  exerciseName: {
    fontSize: 16,
    fontFamily: 'Inter-SemiBold',
    color: '#18181b',
    marginBottom: 4,
  },
  exerciseDetails: {
    fontSize: 14,
    fontFamily: 'Inter-Regular',
    color: '#71717a',
    marginBottom: 8,
  },
  muscleGroups: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  muscleTag: {
    backgroundColor: '#e0e7ff',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 16,
  },
  muscleTagText: {
    fontSize: 12,
    fontFamily: 'Inter-Regular',
    color: '#4f46e5',
  },
});