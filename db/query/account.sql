-- name: GetAccount :one
SELECT * FROM accounts
WHERE acc_id = $1 LIMIT 1;

-- name: ListAccounts :many
SELECT * FROM accounts
ORDER BY acc_code
LIMIT $1
OFFSET $2;

-- name: CreateAccount :one
INSERT INTO accounts (
  acc_code, acc_desc, acc_type, acc_pos, acc_source
) VALUES (
  $1, $2, $3, $4, $5
)
RETURNING *;

-- name: DeleteAccount :exec
DELETE FROM accounts
WHERE acc_id = $1;

-- name: UpdateAccount :one
UPDATE accounts
  set 
  acc_code = $2,
  acc_desc = $3,
  acc_type = $4,
  acc_pos = $5, 
  acc_source =$6
WHERE acc_id = $1
RETURNING *;
