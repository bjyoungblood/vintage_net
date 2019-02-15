defmodule Nerves.NetworkNG do
  alias Nerves.NetworkNG.Ethernet

  @doc """
  Get the path to the nerves network tmp directory
  """
  def tmp_dir() do
    Path.join(System.tmp_dir(), "nerves_network")
  end

  @doc """
  Ensure the tmp directory is created for
  nerves network to use
  """
  def ensure_tmp_dir() do
    File.mkdir_p(tmp_dir())
  end

  @doc """
  Bring some interface up
  """
  def up(%Ethernet{} = ethernet) do
    Ethernet.write_config_file(ethernet)
    Ethernet.up()
  end

  @doc """
  Bring some interface down
  """
  def down(%Ethernet{} = ethernet) do
    Ethernet.write_config_file(ethernet)
    Ethernet.down()
  end

  def run_cmd(command, args) do
    case System.cmd(command, args, stderr_to_stdout: true) do
      {_, 0} -> :ok
      {error, 1} -> {:error, error}
    end
  end
end