package db

import (
	"context"
	"database/sql"
	"rotary/util"
	"testing"
	"time"

	"github.com/stretchr/testify/require"
)

func createRandomAccount(t *testing.T) Account {
	arg := CreateAccountParams{
		AccCode:   util.RandomString(3),
		AccDesc:   "Subscription",
		AccType:   "income",
		AccPos:    int32(util.RandomInt(1, 100)),
		AccSource: true,
	}

	account, err := testQueries.CreateAccount(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, account)

	require.Equal(t, arg.AccCode, account.AccCode)
	require.Equal(t, arg.AccDesc, account.AccDesc)
	require.Equal(t, arg.AccType, account.AccType)

	require.NotZero(t, account.AccID)
	require.NotZero(t, account.CreatedAt)

	return account
}

func TestCreateAccount(t *testing.T) {
	// createRandomAccount(t)
}

func TestGetAccount(t *testing.T) {
	account1 := createRandomAccount(t)
	account2, err := testQueries.GetAccount(context.Background(), account1.AccID)
	require.NoError(t, err)
	require.NotEmpty(t, account2)

	require.Equal(t, account1.AccID, account2.AccID)
	require.Equal(t, account1.AccCode, account2.AccCode)
	require.Equal(t, account1.AccDesc, account2.AccDesc)
	require.Equal(t, account1.AccType, account2.AccType)
	require.WithinDuration(t, account1.CreatedAt, account2.CreatedAt, time.Second)
}

func TestUpdateAccount(t *testing.T) {
	account1 := createRandomAccount(t)

	arg := UpdateAccountParams{
		AccID:     account1.AccID,
		AccCode:   account1.AccCode,
		AccDesc:   account1.AccDesc,
		AccType:   account1.AccType,
		AccSource: false,
		// was up to 100
		AccPos: int32(util.RandomInt(101, 1000)),
	}

	account2, err := testQueries.UpdateAccount(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, account2)

	require.Equal(t, account1.AccID, account2.AccID)
	require.Equal(t, account1.AccCode, account2.AccCode)
	require.Equal(t, arg.AccPos, account2.AccPos)
	require.Equal(t, account1.AccDesc, account2.AccDesc)
	require.WithinDuration(t, account1.CreatedAt, account2.CreatedAt, time.Second)
}

func TestDeleteAccount(t *testing.T) {
	account1 := createRandomAccount(t)
	err := testQueries.DeleteAccount(context.Background(), account1.AccID)
	require.NoError(t, err)

	account2, err := testQueries.GetAccount(context.Background(), account1.AccID)
	require.Error(t, err)
	require.EqualError(t, err, sql.ErrNoRows.Error())
	require.Empty(t, account2)
}

func TestListAccounts(t *testing.T) {
	// var lastAccount Account
	for i := 0; i < 10; i++ {
		// lastAccount = createRandomAccount(t)
		createRandomAccount(t)
	}

	arg := ListAccountsParams{
		// 	// AccDesc:  lastAccount.AccDesc,
		Limit:  5,
		Offset: 0,
	}

	accounts, err := testQueries.ListAccounts(context.Background(), arg)
	// accounts, err := testQueries.ListAccounts(context.Background())
	require.NoError(t, err)
	require.NotEmpty(t, accounts)

	for _, account := range accounts {
		require.NotEmpty(t, account)
		// require.Equal(t, lastAccount.AccDesc, account.AccDesc)
	}
}

// func TestDeleteAllAccounts(t *testing.T) {
// 	var q = "SELECT count(*) FROM accounts"
// 	rows, err := testQueries.GetAccount(context.Background(), q)
// 	if err != nil {
// 		log.Fatal(err)
// 	}
// 	for rows.Next() {
// 	}
// }

func TestRotary(t *testing.T) {
	var accounts = []struct {
		AccCode, AccDesc, AccType string
		AccPos                    int
		AccSource                 bool
	}{
		{"jn", "Jim Nicholson", "con", 34, true},
		{"ms", "Michael Studham", "con", 99, true},
		{"rp", "Robin Page", "con", 98, true},
		{"dm", "David Mander", "con", 97, true},
		{"r", "Raffle", "inc", 3, true},
		{"m", "Meals", "exp", 4, true},
	}

	for _, ac := range accounts {
		arg := CreateAccountParams{
			AccCode:   ac.AccCode,
			AccDesc:   ac.AccDesc,
			AccType:   ac.AccType,
			AccPos:    int32(ac.AccPos),
			AccSource: ac.AccSource,
		}
		account, err := testQueries.CreateAccount(context.Background(), arg)
		require.NoError(t, err)
		require.NotEmpty(t, account)

		require.Equal(t, arg.AccCode, account.AccCode)
		require.Equal(t, arg.AccDesc, account.AccDesc)
		require.Equal(t, arg.AccType, account.AccType)

		require.NotZero(t, account.AccID)
		require.NotZero(t, account.CreatedAt)

	}
}
