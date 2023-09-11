-- name: GetContact :one
SELECT * FROM contacts
WHERE con_id = $1 LIMIT 1;

-- name: ListContacts :many
SELECT * FROM contacts
ORDER BY con_name;

-- name: CreateContact :one
INSERT INTO contacts (
  con_name, con_member
) VALUES (
  $1, $2
)
RETURNING *;

-- name: DeleteContact :exec
DELETE FROM contacts
WHERE con_id = $1;

-- name: UpdateContact :one
UPDATE contacts
  set 
  con_name = $2,
  con_member = $3
WHERE con_id = $1
RETURNING *;
