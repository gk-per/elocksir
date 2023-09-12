defmodule Lock do
  use GenServer

  @moduledoc """
  Defines the structure and functions of a lock.
  """

  defstruct high_water_mark: 0

  # Client API
  def start_link(_) do
    GenServer.start_link(__MODULE__, %Lock{high_water_mark: 0}, name: __MODULE__)
  end

  def issue_key(revision) do
    GenServer.call(__MODULE__, {:issue_key, revision})
  end

  def validate_key(%Key{revision: revision}) do
    GenServer.call(__MODULE__, {:validate_key, revision})
  end

  # Server callbacks
  def init(state) do
    {:ok, state}
  end

  def handle_call({:issue_key, revision}, _from, %Lock{high_water_mark: hwm} = state) do
    if revision > hwm do
      new_state = %Lock{high_water_mark: revision}
      {:reply, :ok, new_state}
    else
      {:reply, {:error, :invalid_revision}, state}
    end
  end

  def handle_call({:validate_key, key_revision}, _from, %Lock{high_water_mark: hwm}) do
    if key_revision >= hwm do
      {:reply, :ok, hwm}
    else
      {:reply, :unauthorized, hwm}
    end
  end

  def handle_call({:validate_key, _key_revision}, _from, state) do
    {:reply, :unauthorized, state}
  end
end
