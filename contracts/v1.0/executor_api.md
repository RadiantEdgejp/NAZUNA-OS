# Executor API Contract v1.0 (Core -> Executor)

## Base
- EXECUTOR_BASE: http://127.0.0.1:8787 (example)
- Authentication:
  - Header: x-nazuna-bridge-secret: <shared_secret>
  - If missing/invalid -> 403 FORBIDDEN

## Operation policy (locked)
- Category A (install/download/expand): MUST require a valid approval token (issued by Core).
- Category D (delete): MUST be rejected ALWAYS.
  - Alternative is allowed: quarantine / disable / move.
- Executor MUST return structured results (stdout/stderr/exit_code).

## POST /exec
Request JSON:
{
  "schema": "nazuna.executor.exec_request.v1",
  "task_id": "<uuid>",
  "step_id": "<uuid>",
  "category": "A|B|C|SAFE",
  "cwd": "<string optional>",
  "cmd": ["bash","-lc","<string>"],
  "timeout_sec": 600,
  "approval": {
    "approval_id": "<uuid>",
    "token": "<string>"
  }
}

Rules:
- If category == "A" or "C" and approval missing -> 403
- If command is delete-like (rm, del, rmdir, shred, wipe, etc) -> 403 ALWAYS

Response JSON:
{
  "schema": "nazuna.executor.exec_result.v1",
  "task_id": "<uuid>",
  "step_id": "<uuid>",
  "exit_code": 0,
  "stdout": "<string>",
  "stderr": "<string>",
  "started_at": "<date-time>",
  "ended_at": "<date-time>",
  "truncated": { "stdout": false, "stderr": false }
}
