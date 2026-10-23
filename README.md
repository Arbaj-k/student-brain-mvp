# Student Brain MVP

Student Brain is a private student workspace for notes, tasks/deadlines, projects, expenses and source-grounded AI questions.

## Existing Supabase project — important
The connected Supabase project already has a `profiles.workspace_data` JSONB workspace store, relational `notes`, `tasks`, `projects`, `expenses` tables with RLS, and an active `student-brain-ai` Edge Function. **Do not run the old `sb_*` table-creation SQL** in `supabase/schema.sql`; this branch uses the existing `profiles.workspace_data` store so it matches the deployed AI function. No database migration is required for this first integration.

## Configure the browser
1. Open `app.js` and set `SUPABASE_URL` to the URL from Supabase Project Settings → API.
2. Set `SUPABASE_ANON_KEY` to the anon/publishable key. Never use a service-role key in browser code.
3. Serve the site over HTTP (VS Code Live Server is fine) or deploy it to a static host. Do not open it via `file://`.
4. In Supabase Auth URL Configuration, configure the correct Site URL and Redirect URLs. Keep email confirmation enabled if that is your preferred security setting.
5. Sign in with an account in the connected Supabase project. Test with non-sensitive sample data first.

## AI
The deployed `student-brain-ai` function expects JSON `{ "message": "..." }`, reads notes/tasks/projects from the signed-in user's `profiles.workspace_data`, and uses the `GEMINI_API_KEY` Supabase secret. The browser sends that request shape. Do not deploy a replacement function until it has been reviewed against the live function and tested.

## Security
- RLS is enabled on the existing profile and relational tables. Current profile policies restrict access to `auth.uid() = id`; data-table policies restrict access to `auth.uid() = user_id`.
- The AI function uses the caller's JWT, verifies the user, and fetches only that user's profile.
- Never commit provider API keys or service-role keys.
- Supabase security advisor currently reports leaked-password protection disabled. Review Supabase Auth password security settings.
- This remains an MVP. Test sign-in, email verification, CRUD, AI grounding, citations, and two-user isolation before public launch.

## Roadmap
1. Configure the public Supabase URL/key in `app.js` and verify login.
2. Test notes/tasks/projects/expenses persistence after sign-out and sign-in.
3. Test AI answers and source labels with realistic saved notes and deadlines.
4. Add automated tests, better retrieval, rate limits, export/deletion controls and deployment documentation.
5. Add WhatsApp integration in a later phase.
