-- name: GetTransaction :one
SELECT * FROM transactions
WHERE tra_id = $1 LIMIT 1;

-- name: ListTransactions :many
SELECT * FROM transactions
ORDER BY tra_id;

-- name: CreateTransaction :one
INSERT INTO transactions (
  tra_per_id, tra_date, tra_reference, tra_contact,
  tra_from_to,
  tra_detail,
  tra_source_id,
  tra_analysis_id,
  tra_gross,
  tra_vat,
  tra_net,
  tra_tick.
  tra_group
) VALUES (
  $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12
)
RETURNING *;

-- name: DeleteTransaction :exec
DELETE FROM transactions
WHERE tra_id = $1;

-- name: UpdateTransaction :one
UPDATE transactions
  set 
  tra_per_id = $2,
  tra_date = $3,
  tra_reference = $4,
  tra_contact = $5,
  tra_from_to = $6 ,
  tra_detail = $7,
  tra_source_id = $8,
  tra_analysis_id = $9,
  tra_gross = $10,
  tra_vat = $11,
  tra_net = $12,
  tra_tick = $13,
  tra_group = $14
WHERE tra_id = $1
RETURNING *;
