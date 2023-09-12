defmodule Elocksir.Application do
  use Application

  def start(_type, _args) do
    children = [
      Elocksir
    ]

    opts = [strategy: :one_for_one, name: Elocksir.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
