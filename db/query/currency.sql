-- name: GetCurrency :one
SELECT * FROM currencies
WHERE cur_id = $1 LIMIT 1;

-- name: ListCurrencies :many
SELECT * FROM currencies
ORDER BY cur_code;

-- name: CreateCurrency :one
INSERT INTO currencies (
  cur_code, cur_desc, cur_symbol
) VALUES (
  $1, $2, $3
)
RETURNING *;

-- name: DeleteCurrency :exec
DELETE FROM currencies
WHERE cur_id = $1;

-- name: UpdateCurrency :one
UPDATE currencies
  set 
  cur_code = $2,
  cur_desc = $3,
  cur_symbol = $4
WHERE cur_id = $1
RETURNING *;
