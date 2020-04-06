defmodule DropSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], [{:name, __MODULE__}])
  end

  def init([]) do
    # worker/3 function specifies a module that the supervisor should
    # start, its argument list, and any options to be given to the
    # workers's start_link funciton
    child = [worker(DropServer, [], [])]
    Supervisor.init(child, [
      # Create a new child process every time a process is supposed to
      # be :permanent fails.
      {:strategy, :one_for_one},
      {:max_restarts, 1},
      {:max_seconds, 5}
    ])
  end
end
