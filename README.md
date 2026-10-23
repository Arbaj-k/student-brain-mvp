# Student Brain MVP

A private student workspace for notes and memory, tasks/deadlines, projects, expenses and source-grounded AI questions.

## Included in this build branch
- Supabase email/password sign-up and sign-in.
- Cloud create/read/update/delete for notes, tasks and projects; expense create/read/delete.
- Per-user row-level security policies on all four data tables.
- Dashboard summaries and upcoming tasks.
- Supabase Edge Function named student-brain-ai. It reads only the authenticated user's records through RLS and sends bounded context to an OpenAI-compatible AI endpoint. It returns source IDs when the model cites them.
- Responsive dark UI, mobile navigation, and setup guidance.

## Setup

1. Open your Supabase project.
2. In the SQL Editor, run the full file supabase/schema.sql.
3. In app.js, replace YOUR_SUPABASE_PROJECT_URL and YOUR_SUPABASE_ANON_OR_PUBLISHABLE_KEY with the project URL and anon/publishable key from Supabase Project Settings → API. These browser keys are public by design; RLS is the security boundary. Never put a service_role/secret key in browser code.
4. In Supabase Auth settings, enable email/password sign-in. If email confirmation is enabled, verify the email before signing in.
5. Run the site through a static HTTP server (VS Code Live Server works) or deploy to a static host. Do not use file:// for the deployed app.
6. Install/use the Supabase CLI and deploy the function:
   supabase login
   supabase link --project-ref YOUR_PROJECT_REF
   supabase functions deploy student-brain-ai
7. Set AI provider secrets in Supabase, never in GitHub or app.js:
   supabase secrets set AI_API_KEY=your_provider_key AI_MODEL=gpt-4o-mini AI_BASE_URL=https://api.openai.com/v1
   AI provider usage may cost money; Supabase database/auth can remain on its free plan. AI chat is unavailable until configured.
8. In Supabase Auth URL Configuration, set your deployed URL as Site URL and add it to Redirect URLs.

## Security and limits
- RLS checks auth.uid() = user_id on every row operation.
- The Edge Function uses the caller JWT; it does not use a service-role key to bypass RLS.
- AI requests send selected saved records to the configured AI provider. Avoid storing secrets or highly sensitive data in notes and review provider data policies.
- This is an MVP, not a completed production audit. AI context currently uses a bounded recent-record set, not hybrid/vector search. Add automated tests, rate limiting, richer source rendering, backups/retention controls and a full deployment test before public launch.
- WhatsApp integration is a later milestone.

## Important repository note
The existing main branch contains Hapn college-event website files, so this implementation is isolated on the student-brain-build branch. Do not overwrite main or deploy until you have reviewed and tested this branch.
