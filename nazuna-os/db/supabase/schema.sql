-- nazuna-os initial schema
create extension if not exists pgcrypto;

create table if not exists org_roles (
  id uuid primary key default gen_random_uuid(),
  role_key text unique not null,
  title text not null,
  description text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists protocols (
  id uuid primary key default gen_random_uuid(),
  protocol_key text unique not null,
  title text not null,
  body_md text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists operation_logs (
  id uuid primary key default gen_random_uuid(),
  actor_role text not null,
  action text not null,
  input_payload jsonb not null default '{}'::jsonb,
  output_payload jsonb not null default '{}'::jsonb,
  reason text,
  created_at timestamptz not null default now()
);

create table if not exists api_requests (
  id uuid primary key default gen_random_uuid(),
  request_title text not null,
  request_type text not null check (request_type in ('code_change', 'deploy')),
  requester text not null,
  approver text,
  status text not null default 'pending' check (status in ('pending', 'approved', 'rejected', 'executed')),
  impact_scope text,
  rollback_plan text,
  executed_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists weekly_improvements (
  id uuid primary key default gen_random_uuid(),
  week_start date not null,
  topic text not null,
  change_summary text not null,
  owner text not null,
  created_at timestamptz not null default now()
);
