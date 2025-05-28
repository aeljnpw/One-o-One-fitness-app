import { useState, useEffect, useCallback } from 'react';
import { View, Text, StyleSheet, TextInput, ScrollView, Image, TouchableOpacity, ActivityIndicator } from 'react-native';
import { Search, Filter, X } from 'lucide-react-native';
import { useRouter } from 'expo-router';
import { supabase } from '@/lib/supabase';

type Equipment = {
  id: string;
  name: string;
  type: string;
  image_url: string;
};

export default function EquipmentCatalog() {
  const router = useRouter();
  const [equipment, setEquipment] = useState<Equipment[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [showFilters, setShowFilters] = useState(false);
  const [selectedType, setSelectedType] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  const fetchEquipment = useCallback(async () => {
    try {
      setLoading(true);
      let query = supabase.from('equipment').select('*').limit(30);
      
      if (searchQuery) {
        query = query.ilike('name', `%${searchQuery}%`);
      }
      
      if (selectedType) {
        query = query.eq('type', selectedType);
      }

      const { data, error: fetchError } = await query;
      
      console.log(
        'Supabase fetch attempt with .limit(30). Data received:',
         data ? data.length : 0, 
        'items. Error:', 
        fetchError
      );

      if (fetchError) throw fetchError;
      
      setEquipment(data || []);
      setError(null);
    } catch (err) {
      setError('Failed to load equipment. Please try again.');
      console.error('Error fetching equipment:', err);
    } finally {
      setLoading(false);
    }
  }, [searchQuery, selectedType]);

  useEffect(() => {
    fetchEquipment();
  }, [fetchEquipment]);

  const types = ['Machine', 'Bench'];

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Discover Equipment</Text>
        <View style={styles.searchContainer}>
          <Search size={20} color="#71717a" style={styles.searchIcon} />
          <TextInput
            style={styles.searchInput}
            placeholder="Search equipment or muscle group"
            placeholderTextColor="#a1a1aa"
            value={searchQuery}
            onChangeText={setSearchQuery}
          />
          {searchQuery ? (
            <TouchableOpacity onPress={() => setSearchQuery('')}>
              <X size={20} color="#71717a" />
            </TouchableOpacity>
          ) : null}
          <TouchableOpacity 
            style={[styles.filterButton, showFilters && styles.filterButtonActive]}
            onPress={() => setShowFilters(!showFilters)}>
            <Filter size={20} color={showFilters ? '#ffffff' : '#3b82f6'} />
          </TouchableOpacity>
        </View>

        {showFilters && (
          <View style={styles.filterContainer}>
            <Text style={styles.filterTitle}>Equipment Type</Text>
            <View style={styles.filterOptions}>
              {types.map((type) => (
                <TouchableOpacity
                  key={type}
                  style={[
                    styles.filterOption,
                    selectedType === type && styles.filterOptionActive,
                  ]}
                  onPress={() => setSelectedType(selectedType === type ? null : type)}>
                  <Text
                    style={[
                      styles.filterOptionText,
                      selectedType === type && styles.filterOptionTextActive,
                    ]}>
                    {type}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>
        )}
      </View>

      {error ? (
        <View style={styles.errorContainer}>
          <Text style={styles.errorText}>{error}</Text>
          <TouchableOpacity
            style={styles.retryButton}
            onPress={fetchEquipment}>
            <Text style={styles.retryButtonText}>Retry</Text>
          </TouchableOpacity>
        </View>
      ) : loading ? (
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color="#3b82f6" />
        </View>
      ) : (
        <ScrollView style={styles.equipmentList}>
          {equipment.map((item) => (
            <TouchableOpacity
              key={item.id}
              style={styles.equipmentCard}
              onPress={() => router.push(`/${item.id}`)}>
              <Image source={{ uri: item.image_url }} style={styles.equipmentImage} />
              <View style={styles.equipmentInfo}>
                <Text style={styles.equipmentName}>{item.name}</Text>
                <Text style={styles.equipmentType}>{item.type}</Text>
              </View>
            </TouchableOpacity>
          ))}
        </ScrollView>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ffffff',
  },
  header: {
    padding: 24,
    paddingTop: 60,
    backgroundColor: '#ffffff',
  },
  title: {
    fontFamily: 'Inter-Bold',
    fontSize: 32,
    color: '#18181b',
    marginBottom: 16,
  },
  searchContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#f4f4f5',
    borderRadius: 12,
    padding: 12,
  },
  searchIcon: {
    marginRight: 8,
  },
  searchInput: {
    flex: 1,
    fontSize: 16,
    fontFamily: 'Inter-Regular',
    color: '#18181b',
  },
  filterButton: {
    marginLeft: 12,
    padding: 8,
    borderRadius: 8,
    backgroundColor: '#f4f4f5',
  },
  filterButtonActive: {
    backgroundColor: '#3b82f6',
  },
  filterContainer: {
    marginTop: 16,
    padding: 16,
    backgroundColor: '#f4f4f5',
    borderRadius: 12,
  },
  filterTitle: {
    fontSize: 16,
    fontFamily: 'Inter-SemiBold',
    color: '#18181b',
    marginBottom: 12,
  },
  filterOptions: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  filterOption: {
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    backgroundColor: '#ffffff',
    borderWidth: 1,
    borderColor: '#e4e4e7',
  },
  filterOptionActive: {
    backgroundColor: '#3b82f6',
    borderColor: '#3b82f6',
  },
  filterOptionText: {
    fontSize: 14,
    fontFamily: 'Inter-Regular',
    color: '#71717a',
  },
  filterOptionTextActive: {
    color: '#ffffff',
  },
  equipmentList: {
    padding: 16,
  },
  equipmentCard: {
    backgroundColor: '#ffffff',
    borderRadius: 16,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 3,
    overflow: 'hidden',
  },
  equipmentImage: {
    width: '100%',
    height: 200,
    resizeMode: 'cover',
  },
  equipmentInfo: {
    padding: 16,
  },
  equipmentName: {
    fontFamily: 'Inter-SemiBold',
    fontSize: 18,
    color: '#18181b',
    marginBottom: 4,
  },
  equipmentType: {
    fontFamily: 'Inter-Regular',
    fontSize: 14,
    color: '#71717a',
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
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
});