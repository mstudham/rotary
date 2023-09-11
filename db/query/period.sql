-- name: GetPeriod :one
SELECT * FROM periods
WHERE per_id = $1 LIMIT 1;

-- name: ListPeriods :many
SELECT * FROM periods
ORDER BY per_desc;

-- name: CreatePeriod :one
INSERT INTO periods (
  per_desc
) VALUES (
  $1
)
RETURNING *;

-- name: DeletePeriod :exec
DELETE FROM periods
WHERE per_id = $1;

-- name: UpdatePeriod :one
UPDATE periods
  set 
  per_desc = $2
WHERE per_id = $1
RETURNING *;
