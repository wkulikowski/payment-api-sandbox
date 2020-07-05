defmodule Balance do
  @derive Jason.Encoder
  defstruct available: 0, ledger: 0
end

defmodule Institution do
  @derive Jason.Encoder
  defstruct id: "", name: ""
end

defmodule RoutingNumbers do
  @derive Jason.Encoder
  defstruct ach: "", wire: ""
end

defmodule TellerSandbox.Account do
  @derive {Jason.Encoder, only: [:account_number,
                                 :balances,
                                 :currency_code,
                                 :enrollment_id,
                                 :id,
                                 :institution,
                                 :name,
                                 :routing_numbers]}
  defstruct account_number: "",
            balances: %Balance{},
            currency_code: "USD",
            enrollment_id: "",
            id: "",
            institution: %Institution{},
            name: "",
            routing_numbers: %RoutingNumbers{},
            inflow: 0,
            outflow: 0
end