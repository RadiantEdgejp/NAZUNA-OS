# DB Required Fields v1.0 (Core -> DB)

目的：event→task→step→approval→artifact を task_id で追跡できる“最小構成”を固定する。

## events
- event_id (uuid, PK)
- occurred_at (timestamptz)
- source (text)
- type (text)
- actor_id (text)
- guild_id (text)
- channel_id (text)
- message_id (text, nullable)
- interaction_id (text, nullable)
- payload_json (jsonb)

## tasks
- task_id (uuid, PK)
- created_at (timestamptz)
- status (text: queued|running|paused_approval|done|failed)
- priority (int)
- lane (text)
- title (text)
- objective (text)
- root_event_id (uuid, FK->events.event_id)
- meta_json (jsonb)

## steps
- step_id (uuid, PK)
- task_id (uuid, FK->tasks.task_id)
- step_index (int)
- status (text: queued|running|paused_approval|done|failed)
- started_at (timestamptz, nullable)
- ended_at (timestamptz, nullable)
- kind (text: plan|exec|approval_wait|summarize|deliver)
- input_json (jsonb)
- output_json (jsonb)

## approvals
- approval_id (uuid, PK)
- task_id (uuid, FK->tasks.task_id)
- type (text: A|C)
- status (text: pending|approved|rejected|expired)
- requested_at (timestamptz)
- decided_at (timestamptz, nullable)
- decided_by (text, nullable)
- decision_json (jsonb)

## artifacts
- artifact_id (uuid, PK)
- task_id (uuid, FK->tasks.task_id)
- step_id (uuid, FK->steps.step_id, nullable)
- kind (text)
- title (text)
- content_text (text, nullable)
- storage_ref (text, nullable)
- meta_json (jsonb)
- created_at (timestamptz)

## fix_ledger
- fix_id (uuid, PK)
- created_at (timestamptz)
- task_id (uuid, FK->tasks.task_id)
- component (text)              # gateway/core/executor/db/discord など
- symptom (text)                # 何が壊れてたか
- root_cause (text)             # 原因
- action (text)                 # 施策（変更内容）
- verification (text)           # 検証結果（ログ/手順/期待との差）
- evidence_ref (text, nullable) # journalctl貼付ID/URL/参照など
- status (text: proposed|applied|verified|reverted)
- meta_json (jsonb)
