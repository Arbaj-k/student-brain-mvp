# Student Brain MVP

A browser-based student workspace with Supabase authentication, cloud-synced notes, tasks, projects and expenses, plus an AI assistant backed by a Supabase Edge Function.

## Features
- Supabase sign-up and sign-in
- Per-user cloud-synced workspace
- Notes, planner tasks, projects and expense tracking
- AI chat through the `student-brain-ai` Supabase Edge Function
- Responsive desktop/mobile layout

## Project files
- `index.html` — application UI
- `styles.css` — styling
- `app.js` — client-side app and Supabase integration
- `supabase-schema.sql` — database schema and row-level security policies
- `supabase-cloud-sync-migration.sql` — cloud workspace storage migration
- `supabase/functions/student-brain-ai/index.ts` — AI Edge Function

## Setup
1. Create a Supabase project.
2. Run `supabase-schema.sql` in the Supabase SQL Editor.
3. Run `supabase-cloud-sync-migration.sql` if using the `profiles.workspace_data` cloud-sync approach.
4. Configure the Supabase project URL and publishable/anon key in `app.js`.
5. Deploy the `student-brain-ai` Edge Function and set `GEMINI_API_KEY` as a Supabase Function Secret. Never commit API keys or the Supabase service-role key.

## Security notes
The browser may contain only the Supabase publishable/anon key. Keep Gemini API keys and service-role keys on the server/Edge Function. Ensure Row Level Security policies restrict each user's data to their own authenticated user ID before using real personal data.

## Hosting
The frontend is static and can be hosted on GitHub Pages or another static host. Supabase authentication, database and Edge Function remain hosted in Supabase.