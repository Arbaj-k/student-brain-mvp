-- Safety note: this project already has a live Student Brain schema.
-- Do NOT run the former sb_notes/sb_tasks/sb_projects/sb_expenses DDL from old commits.
-- The current frontend stores workspace data in public.profiles.workspace_data.
-- Existing public.notes/tasks/projects/expenses tables and RLS policies were verified.
-- No migration is needed for this initial integration.
-- To inspect tables safely, use Supabase Dashboard -> Table Editor, or run:
select table_name
from information_schema.tables
where table_schema = 'public'
  and table_name in ('profiles','notes','tasks','projects','expenses','whatsapp_connections')
order by table_name;
