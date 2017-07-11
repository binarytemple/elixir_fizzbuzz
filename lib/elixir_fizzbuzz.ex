defmodule FizzBuzzApp do
  use Application

  def start(_type, _args) do
      # Cowboy has it's own supervision tree.. no supervisor needed
      Plug.Adapters.Cowboy.http(FizzBuzzPipeline , %{})
  end

end

defmodule FizzBuzzPlug do
  require Logger
  
	use Plug.Router

  #if Mix.env == :dev do
	#	use Plug.Debugger
  #end

  use Plug.ErrorHandler

	plug :match
	plug :dispatch

	get "/" do
      ret = """
      Available endpoints:

      GET /fizzbuzz/:num
      """
      conn |> send_resp(500,ret)
	end



	get "/fizzbuzz/:num" do
      ret = FizzBuzz.evaluate(elem(Integer.parse(num),0))
      conn |> send_resp(200,ret)
	end

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack} = args) do
		uuid = UUID.uuid1()
		err = "Error #{uuid} : args : #{inspect(conn.path_info)} " 
		Logger.error("#{err} : #{inspect(args)}")
    send_resp(conn, conn.status, err)
  end

end

defmodule FizzBuzzPipeline do
   
  # We use Plug.Builder to have access to the plug/2 macro.
  # This macro can receive a function or a module plug and an
  # optional parameter that will be passed unchanged to the 
  # given plug.
  use Plug.Builder

  plug Plug.Logger
  plug FizzBuzzPlug, %{}

end

defmodule FizzBuzz do

  def evaluate(number) when is_integer(number) do
    case number do
      x when rem(x,15) == 0 -> "fizzbuzz"
      x when rem(x, 3) == 0 -> "fizz"
      x when rem(x, 5) == 0 -> "buzz"
      x -> Integer.to_string(x)
    end 
  end

end
