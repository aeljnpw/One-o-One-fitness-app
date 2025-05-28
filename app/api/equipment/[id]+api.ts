import { supabase } from '@/lib/supabase';

export async function GET(request: Request) {
  try {
    const id = request.url.split('/').pop();

    const { data: equipment, error: equipmentError } = await supabase
      .from('equipment')
      .select('*')
      .eq('id', id)
      .single();

    if (equipmentError) {
      return new Response(JSON.stringify({ error: equipmentError.message }), {
        status: 404,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    const { data: exercises, error: exercisesError } = await supabase
      .from('exercises')
      .select('id, title, difficulty, duration, primary_muscles, secondary_muscles')
      .eq('equipment_id', id);

    if (exercisesError) {
      return new Response(JSON.stringify({ error: exercisesError.message }), {
        status: 500,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    return Response.json({ equipment, exercises });
  } catch (error) {
    return new Response(JSON.stringify({ error: 'Internal server error' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
}