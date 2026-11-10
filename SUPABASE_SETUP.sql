-- HUỲNH CẢNH PC QUOTATION PRO V3
-- Chạy toàn bộ SQL này trong Supabase > SQL Editor > New query > Run.
-- Dự án dùng chung cho nhân viên được đăng nhập. Không bật public access.
create table if not exists public.hcpc_store_settings (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_by uuid references auth.users(id),
  updated_at timestamptz not null default now()
);
create table if not exists public.hcpc_quotes (
  local_id text primary key,
  data jsonb not null,
  customer_name text not null default '',
  quote_no text not null default '',
  total numeric not null default 0,
  created_by uuid references auth.users(id),
  updated_at timestamptz not null default now()
);
create table if not exists public.hcpc_pc_configs (
  local_id text primary key,
  name text not null default '',
  data jsonb not null,
  created_by uuid references auth.users(id),
  updated_at timestamptz not null default now()
);

alter table public.hcpc_store_settings enable row level security;
alter table public.hcpc_quotes enable row level security;
alter table public.hcpc_pc_configs enable row level security;

-- Chỉ người dùng đã đăng nhập vào dự án mới được đọc/ghi dữ liệu.
drop policy if exists "signed_in_all_store_settings" on public.hcpc_store_settings;
create policy "signed_in_all_store_settings" on public.hcpc_store_settings
for all to authenticated using (true) with check (true);

drop policy if exists "signed_in_all_quotes" on public.hcpc_quotes;
create policy "signed_in_all_quotes" on public.hcpc_quotes
for all to authenticated using (true) with check (true);

drop policy if exists "signed_in_all_pc_configs" on public.hcpc_pc_configs;
create policy "signed_in_all_pc_configs" on public.hcpc_pc_configs
for all to authenticated using (true) with check (true);

grant select, insert, update, delete on public.hcpc_store_settings to authenticated;
grant select, insert, update, delete on public.hcpc_quotes to authenticated;
grant select, insert, update, delete on public.hcpc_pc_configs to authenticated;
