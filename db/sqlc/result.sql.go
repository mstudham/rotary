// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.20.0
// source: result.sql

package db

import (
	"context"
	"database/sql"
)

const createResult = `-- name: CreateResult :one
INSERT INTO results (
  res_per_id, res_acc_id,
  res_currency, res_amount
) VALUES (
  $1, $2, $3, $4
)
RETURNING res_id, res_per_id, res_acc_id, res_currency, res_amount, created_at
`

type CreateResultParams struct {
	ResPerID    sql.NullString
	ResAccID    sql.NullString
	ResCurrency sql.NullString
	ResAmount   sql.NullString
}

func (q *Queries) CreateResult(ctx context.Context, arg CreateResultParams) (Result, error) {
	row := q.db.QueryRowContext(ctx, createResult,
		arg.ResPerID,
		arg.ResAccID,
		arg.ResCurrency,
		arg.ResAmount,
	)
	var i Result
	err := row.Scan(
		&i.ResID,
		&i.ResPerID,
		&i.ResAccID,
		&i.ResCurrency,
		&i.ResAmount,
		&i.CreatedAt,
	)
	return i, err
}

const deleteResult = `-- name: DeleteResult :exec
DELETE FROM results
WHERE res_id = $1
`

func (q *Queries) DeleteResult(ctx context.Context, resID int32) error {
	_, err := q.db.ExecContext(ctx, deleteResult, resID)
	return err
}

const getResult = `-- name: GetResult :one
SELECT res_id, res_per_id, res_acc_id, res_currency, res_amount, created_at FROM results
WHERE res_id = $1 LIMIT 1
`

func (q *Queries) GetResult(ctx context.Context, resID int32) (Result, error) {
	row := q.db.QueryRowContext(ctx, getResult, resID)
	var i Result
	err := row.Scan(
		&i.ResID,
		&i.ResPerID,
		&i.ResAccID,
		&i.ResCurrency,
		&i.ResAmount,
		&i.CreatedAt,
	)
	return i, err
}

const listResults = `-- name: ListResults :many
SELECT res_id, res_per_id, res_acc_id, res_currency, res_amount, created_at FROM results
ORDER BY res_id
`

func (q *Queries) ListResults(ctx context.Context) ([]Result, error) {
	rows, err := q.db.QueryContext(ctx, listResults)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Result
	for rows.Next() {
		var i Result
		if err := rows.Scan(
			&i.ResID,
			&i.ResPerID,
			&i.ResAccID,
			&i.ResCurrency,
			&i.ResAmount,
			&i.CreatedAt,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const updateResult = `-- name: UpdateResult :one
UPDATE results
  set 
  res_per_id = $2,
  res_acc_id = $3,
  res_currency = $4, 
  res_amount =$5
WHERE res_id = $1
RETURNING res_id, res_per_id, res_acc_id, res_currency, res_amount, created_at
`

type UpdateResultParams struct {
	ResID       int32
	ResPerID    sql.NullString
	ResAccID    sql.NullString
	ResCurrency sql.NullString
	ResAmount   sql.NullString
}

func (q *Queries) UpdateResult(ctx context.Context, arg UpdateResultParams) (Result, error) {
	row := q.db.QueryRowContext(ctx, updateResult,
		arg.ResID,
		arg.ResPerID,
		arg.ResAccID,
		arg.ResCurrency,
		arg.ResAmount,
	)
	var i Result
	err := row.Scan(
		&i.ResID,
		&i.ResPerID,
		&i.ResAccID,
		&i.ResCurrency,
		&i.ResAmount,
		&i.CreatedAt,
	)
	return i, err
}