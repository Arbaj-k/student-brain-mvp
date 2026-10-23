# Student Brain MVP

A private student workspace for notes and memory, tasks/deadlines, projects, expenses, and source-grounded AI Q&A.

## First implementation
- Supabase email/password authentication.
- Cloud CRUD for notes, tasks, projects and expenses.
- Row-level security policies scoped to the signed-in user.
- Dashboard summaries and task completion.
- Supabase Edge Function that fetches the current user's saved records using their JWT and asks an OpenAI-compatible model to answer from those records.
- AI provider credentials stay in Supabase function secrets, never in browser code.

## Setup
1. Open your Supabase project.
2. Run the entire file supabase/schema.sql in Supabase SQL Editor.
3. In this branch's index.html, replace CONFIG.url with your Supabase Project URL and CONFIG.key with your anon/publishable key. These browser keys are public; RLS protects the data. Never use the service-role key here.
4. In Supabase Authentication, enable email/password. If email verification is enabled, verify the sign-up email before signing in.
5. Deploy the static index.html to a static host or run it using VS Code Live Server. Do not open it with file://.
6. Install the Supabase CLI, sign in and link the project, then deploy:
   supabase login
   supabase link --project-ref YOUR_PROJECT_REF
   supabase functions deploy student-brain-ai
7. Configure AI provider secrets in Supabase, not in GitHub/browser code:
   supabase secrets set AI_API_KEY=your_provider_key AI_MODEL=gpt-4o-mini AI_BASE_URL=https://api.openai.com/v1
   A compatible provider and model can be substituted. AI answers are unavailable until the function and secrets are configured.
8. In Supabase Auth URL Configuration, set the deployed app as Site URL and add it to Redirect URLs.

## Security
- RLS is enabled on all four user data tables. Each policy requires auth.uid() = user_id.
- The Edge Function queries with the caller's JWT and does not bypass RLS with a service-role key.
- The browser only contains the Supabase anon/publishable key. Never commit AI keys or service-role keys.
- The AI provider receives the selected saved records as context. Avoid saving passwords, API keys or other secrets in notes.
- This is an MVP, not a production security audit. Before public launch, add tests, rate limiting, data export/deletion controls, and explicit source citation UX.

## Roadmap
1. Verify auth, RLS, and CRUD with two separate test accounts.
2. Improve AI source citations and grounding tests.
3. Add embeddings/hybrid retrieval for older context instead of only the most recent bounded set.
4. Add calendar/reminders and file attachments.
5. Add WhatsApp integration after privacy and authentication flows are validated.

## Important repository note
This implementation lives on the separate student-brain-build branch. The existing main branch contains Hapn college-events code; it was intentionally not overwritten. Review and test this branch before changing the default branch or deployment settings.
