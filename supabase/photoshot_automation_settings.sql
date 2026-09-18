-- =============================================================
--  Photoshot · 프로필 사진 자동화 모드 설정 (계정별 1행)
--  nolging 프로젝트의 Supabase SQL Editor에 붙여넣어 한 번 실행하세요.
--  nolging의 기존 auth.users/profiles 계정을 그대로 사용하며, 이 테이블은
--  photoshot 전용이라 nolging 앱 자체의 화면/기능에는 영향이 없습니다.
-- =============================================================

create table if not exists public.photoshot_automation_settings (
  user_id        uuid primary key references auth.users(id) on delete cascade,
  resize_size    integer not null default 700,
  blur_amount    numeric not null default 2,
  noise_amount   numeric not null default 12,
  sc_range       text    not null default 'black'
                 check (sc_range in ('red','yellow','green','cyan','blue','magenta','white','neutral','black')),
  sc_c           numeric not null default 0,
  sc_m           numeric not null default 0,
  sc_y           numeric not null default 0,
  sc_k           numeric not null default 100,
  lv_in_b        numeric not null default 20,
  lv_in_w        numeric not null default 255,
  lv_gamma       numeric not null default 1.30,
  lv_out_b       numeric not null default 0,
  lv_out_w       numeric not null default 255,
  curve_points   jsonb   not null default '[[0,0],[65,79],[177,194],[255,255]]',
  lips_blend_mode text   not null default 'linear-burn',
  lips_opacity   numeric not null default 0.22,
  updated_at     timestamptz not null default now()
);

alter table public.photoshot_automation_settings enable row level security;

-- 본인 설정만 읽고/쓸 수 있음 (다른 계정 설정은 조회조차 불가).
drop policy if exists pas_select on public.photoshot_automation_settings;
create policy pas_select on public.photoshot_automation_settings
  for select to authenticated using (user_id = auth.uid());

drop policy if exists pas_insert on public.photoshot_automation_settings;
create policy pas_insert on public.photoshot_automation_settings
  for insert to authenticated with check (user_id = auth.uid());

drop policy if exists pas_update on public.photoshot_automation_settings;
create policy pas_update on public.photoshot_automation_settings
  for update to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
