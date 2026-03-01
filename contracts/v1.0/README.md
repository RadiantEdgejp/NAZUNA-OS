# contracts v1.0 (LOCKED)

このディレクトリは Nazuna/Clawd OS の「契約」です。
- v1.0 は変更禁止（破るなら v2.0 を作る）
- v1.0 への変更は「後方互換の追加」だけ許可
  - 追加フィールドは optional のみ
  - 既存フィールドの型変更/必須化/削除/意味変更は禁止

対象：
- EventEnvelope (Gateway -> Core)
- DiscordOutbox (Core -> Gateway)
- ApprovalDecision (Gateway -> Core)
- Executor API (Core -> Executor)
- DB Required Fields (Core -> DB)
