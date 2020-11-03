defmodule SequenceSupTest do
  use ExUnit.Case
  doctest SequenceSup

  test "greets the world" do
    assert SequenceSup.hello() == :world
  end
end
