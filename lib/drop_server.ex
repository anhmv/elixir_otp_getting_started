defmodule DropServer do
  use GenServer

  @moduledoc """
  The simple GenServer (Generic Server) that done much of work as the
  core of a program -- calculating results, storing information,
  and preparing replies.

  ## Examples
    iex> GenServer.start_link()
    iex> GenServer.call(DropServer, 20)
    iex> GenServer.call(DropServer, 40)
    iex> GenServer.cast(DropServer, {})
  """

  defmodule State do
    defstruct count: 0
  end

  def start_link do
    # The first argument is an atom (__MODULE__) that will be expaneded
    # to the name of current module, and that will be used as the name
    # for this process.
    #
    # The second argument is a list of arguments to be passed to the
    # module's initialization `init([])`
    #
    # The third argument is the options of the start_link function
    #
    # See more: https://hexdocs.pm/elixir/GenServer.html#start_link/3
    GenServer.start_link(__MODULE__, [], [{:name, __MODULE__}])
  end

  # There are the callbacks that the GenServer behavior will use
  # init/1 gets called only when start_link sets up the service.
  # it does not get called if we recompile the code.
  # Triggered by GenServer.start_link
  def init([]) do
    {:ok, %State{}}
  end

  # Handles synchronous calls, triggered by GenServer.call
  def handle_call(request, _from, state) do
    distance = request
    reply = {:ok, fall_velocity(distance)}
    new_state = %State{count: state.count + 1}
    {:reply, reply, new_state}
  end

  # Handles asynchronous calls, triggered by GenServer.cast
  def handle_cast(_msg, state) do
    IO.puts("So far, calculated #{state.count} velocities.")
    {:noreply, state}
  end

  # Dealing with non-otp messages
  def handle_info(_info, state) do
    {:noreply, state}
  end

  # Cleans up the process
  def terminate(_reason, _state) do
    {:ok}
  end

  # Let you switch out code without losing state
  def code_change(_old_version, state, _extra) do
    {:ok, state}
  end

  def fall_velocity(distance) do
    :math.sqrt(2 * 9.8 * distance)
  end
end
