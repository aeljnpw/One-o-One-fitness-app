export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      equipment: {
        Row: {
          id: string
          name: string
          type: string
          image_url: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          name: string
          type: string
          image_url?: string | null
          created_at?: string | null
        }
        Update: {
          id?: string
          name?: string
          type?: string
          image_url?: string | null
          created_at?: string | null
        }
      }
      exercises: {
        Row: {
          id: string
          equipment_id: string | null
          title: string
          video_url: string | null
          instructions: string[]
          tips: string[]
          difficulty: string
          duration: number
          primary_muscles: string[]
          secondary_muscles: string[]
          created_at: string | null
        }
        Insert: {
          id?: string
          equipment_id?: string | null
          title: string
          video_url?: string | null
          instructions?: string[]
          tips?: string[]
          difficulty: string
          duration?: number
          primary_muscles?: string[]
          secondary_muscles?: string[]
          created_at?: string | null
        }
        Update: {
          id?: string
          equipment_id?: string | null
          title?: string
          video_url?: string | null
          instructions?: string[]
          tips?: string[]
          difficulty?: string
          duration?: number
          primary_muscles?: string[]
          secondary_muscles?: string[]
          created_at?: string | null
        }
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}