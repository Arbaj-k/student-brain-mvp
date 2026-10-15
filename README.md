# Student Brain MVP

A student-focused personal workspace with notes, tasks, projects, expenses, Supabase authentication/cloud sync, and an AI assistant powered by a Supabase Edge Function.

## Security
- Keep `GEMINI_API_KEY` only in Supabase Edge Function Secrets.
- Never commit service-role keys, passwords, `.env` files, or user data.
- The Supabase publishable/anon key in the browser is expected to be public; enforce Row Level Security (RLS) on database tables.

## Setup
See the full project README and Supabase SQL files for setup instructions.
