defmodule ElixirPlugPoc.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_fizzbuzz ,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    applications(Mix.env)
  end
  
  def applications(_) do
    [ 
    #      mod: {FizzBuzz, []},
      applications: [
        :logger, 
        :httpoison, 
        :cowboy, 
        :plug,
        :uuid 
      ]
    ]
  end

  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:plug       , "~> 1.0"   } ,
      {:cowboy     , "~> 1.0"   } ,
      {:httpoison  , "~> 0.12.0" } ,
      {:exrm       , "~> 1.0.3" } ,
      {:uuid       , "~> 1.1.7" } ,
      {:mix_docker , "~> 0.5.0" }
    ]
  end
end
