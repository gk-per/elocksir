defmodule Key do
  @moduledoc """
  Defines the structure and functions of a key.
  """

  defstruct revision: 0

  @spec new(integer) :: %Key{}
  def new(revision) do
    %Key{revision: revision}
  end
end
