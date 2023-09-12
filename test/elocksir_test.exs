defmodule LockTest do
  use ExUnit.Case

  test "issue and validate keys" do
    {:ok, _pid} = Lock.start_link(%Lock{high_water_mark: 0})

    assert :ok == Lock.issue_key(1)

    assert :ok == Lock.validate_key(%Key{revision: 1})

    assert :unauthorized == Lock.validate_key(%Key{revision: 0})
  end
end
