import { supabase } from '@/lib/supabase';

export async function GET(request: Request) {
  try {
    const url = new URL(request.url);
    const searchQuery = url.searchParams.get('search');
    const type = url.searchParams.get('type');

    let query = supabase.from('equipment').select('*');
    
    if (searchQuery) {
      query = query.ilike('name', `%${searchQuery}%`);
    }
    
    if (type) {
      query = query.eq('type', type);
    }

    const { data, error } = await query;
    
    if (error) {
      return new Response(JSON.stringify({ error: error.message }), {
        status: 500,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    return Response.json(data);
  } catch (error) {
    return new Response(JSON.stringify({ error: 'Internal server error' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
}