defmodule FizzBuzzTest do
  use ExUnit.Case
  use ExUnit.Case, async: true
  require ExUnit.Assertions
  use Plug.Test

  @opts FizzBuzzPlug.init(%{})

  test "Basic rules of fizzbuzz" do
    assert FizzBuzz.evaluate(3)  == "fizz"
    assert FizzBuzz.evaluate(5)  == "buzz"
    assert FizzBuzz.evaluate(15) == "fizzbuzz"
    assert FizzBuzz.evaluate(16) == "16"
  end

   test "test the fizzbuzz endpoint with 3" do
     conn = conn(:get, "/fizzbuzz/3")
     # Invoke the plug
     conn = FizzBuzzPlug.call(conn, @opts)
     assert conn.state == :sent
     assert conn.status == 200
     assert conn.resp_body == "fizz"
   end

  test "test the fizzbuzz endpoint with garbage input" do
    conn = conn(:get, "/fizzbuzz/foobar")
    assert_raise ArgumentError, ~r/argument error/, fn ->
      FizzBuzzPlug.call(conn, @opts)
    end
  end

end
