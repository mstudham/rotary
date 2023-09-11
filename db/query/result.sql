-- name: GetResult :one
SELECT * FROM results
WHERE res_id = $1 LIMIT 1;

-- name: ListResults :many
SELECT * FROM results
ORDER BY res_id;

-- name: CreateResult :one
INSERT INTO results (
  res_per_id, res_acc_id,
  res_currency, res_amount
) VALUES (
  $1, $2, $3, $4
)
RETURNING *;

-- name: DeleteResult :exec
DELETE FROM results
WHERE res_id = $1;

-- name: UpdateResult :one
UPDATE results
  set 
  res_per_id = $2,
  res_acc_id = $3,
  res_currency = $4, 
  res_amount =$5
WHERE res_id = $1
RETURNING *;

