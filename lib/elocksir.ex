defmodule Elocksir do
  use Supervisor
  alias Lock

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      {Lock, []}  # Initialize the Lock GenServer
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def issue_key(revision) do
    Lock.issue_key(revision)
  end

  def validate_key(key) do
    Lock.validate_key(key)
  end
end
