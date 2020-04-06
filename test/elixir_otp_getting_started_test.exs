defmodule ElixirOtpGettingStartedTest do
  use ExUnit.Case
  doctest ElixirOtpGettingStarted

  test "greets the world" do
    assert ElixirOtpGettingStarted.hello() == :world
  end
end
