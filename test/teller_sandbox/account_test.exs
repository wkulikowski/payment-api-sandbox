defmodule TellerSandbox.BalanceTest do
  use ExUnit.Case

  test "calculate balance" do
    today = ~D[2020-06-30]
    account_1 = TellerSandboxWeb.Factory.account_factory(600, 100, ~D[2020-06-06])
    account_2 = TellerSandboxWeb.Factory.account_factory(1000, 5, ~D[2020-06-25])
    account_3 = TellerSandboxWeb.Factory.account_factory(0, 100, ~D[2020-06-01])
    account_4 = TellerSandboxWeb.Factory.account_factory(2000, 100, ~D[2020-06-23])

    assert Balance.get_account_balance(account_1, today) == %Balance{
             available: -300,
             ledger: -300
           }

    assert Balance.get_account_balance(account_2, today) == %Balance{available: -25, ledger: -25}

    assert Balance.get_account_balance(account_3, today) == %Balance{
             available: -2500,
             ledger: -2500
           }

    assert Balance.get_account_balance(account_4, today) == %Balance{
             available: 1400,
             ledger: 1400
           }
  end

  test "set account balance" do
    account = TellerSandboxWeb.Factory.account_factory(900, 100, ~D[2020-07-01])

    account = TellerSandbox.Account.set_account_balance(account, ~D[2020-07-09])
    assert account.balances.available == 200
    assert account.balances.ledger == 200
  end

  test "get account links" do
    account = TellerSandboxWeb.Factory.account_factory()
    links = AccountLinks.get_account_links(account)

    assert links.self == TellerSandboxWeb.Endpoint.url() <> "/api/accounts/test_acc_11111111"
    assert links.transactions == TellerSandboxWeb.Endpoint.url() <> "/api/accounts/test_acc_11111111/transactions"
  end

  test "set account links" do
    account = TellerSandboxWeb.Factory.account_factory()
    |> TellerSandbox.Account.set_links()

    assert account.links.self == TellerSandboxWeb.Endpoint.url() <> "/api/accounts/test_acc_11111111"
    assert account.links.transactions == TellerSandboxWeb.Endpoint.url() <> "/api/accounts/test_acc_11111111/transactions"

  end
end
