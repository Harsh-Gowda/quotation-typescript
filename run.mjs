import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  'https://xlpxcijivqxedgjeklzy.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFub24iLCJpYXQiOjE3NzE5MTY5ODcsImV4cCI6MjA4NzQ5Mjk4N30.sULy8klGbG2Tu8cYzEPUvP30uu7aSdkDE4o7DyQ81jI'
);

async function main() {
  const { data, error } = await supabase.from('product_categories').select('*');
  if (error) {
    console.error("Error:", error);
  } else {
    console.log("Categories:", JSON.stringify(data, null, 2));
  }
}

main();
