-- Enable RLS
alter table org_roles enable row level security;
alter table protocols enable row level security;
alter table operation_logs enable row level security;
alter table api_requests enable row level security;
alter table weekly_improvements enable row level security;

-- Basic authenticated access model (adjust per project auth design)
create policy if not exists "authenticated_read_roles"
on org_roles
for select
using (auth.role() = 'authenticated');

create policy if not exists "authenticated_read_protocols"
on protocols
for select
using (auth.role() = 'authenticated');

create policy if not exists "authenticated_insert_logs"
on operation_logs
for insert
with check (auth.role() = 'authenticated');

create policy if not exists "authenticated_read_logs"
on operation_logs
for select
using (auth.role() = 'authenticated');

create policy if not exists "authenticated_manage_api_requests"
on api_requests
for all
using (auth.role() = 'authenticated')
with check (auth.role() = 'authenticated');

create policy if not exists "authenticated_manage_weekly_improvements"
on weekly_improvements
for all
using (auth.role() = 'authenticated')
with check (auth.role() = 'authenticated');
