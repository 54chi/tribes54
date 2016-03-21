ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Tribes54.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Tribes54.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Tribes54.Repo)

