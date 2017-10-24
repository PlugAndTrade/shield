defmodule Shield.GetConfig do
  def get_env(config, [ key | [ _ | _ ] = keys ]) do
    config
      |> get_env(key)
      |> get_env(keys)
  end

  def get_env(config, [ key ]) do
    config
      |> get_env(key)
  end

  def get_env(_, []) do
    raise ArgumentError, message: "Key list may not be empty"
  end

  def get_env(config, key) when is_atom(config) do
    config
      |> Application.get_env(key)
      |> get_value()
  end

  def get_env(config, key) when is_map(config) do
    config
      |> Map.get(key)
      |> get_value()
  end

  defp get_value({:system, var, default}), do: System.get_env(var) || default
  defp get_value({:system, var}), do: System.get_env(var)
  defp get_value(value), do: value

end
