defmodule Sequence.Server do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def next_number do
    GenServer.call __MODULE__, :next_number
  end

  def increment_number(delta) do
    GenServer.cast __MODULE__, {:increment_number, delta}
  end

  @impl true
  def init(_) do
    { :ok, Sequence.Stash.get() }
  end

  @impl true
  def handle_call(:next_number, _from, current_number) do
    { :reply, current_number, current_number + 1}
  end

  @impl true
  def handle_cast({:increment_number, delta}, current_number) do
    { :noreply, current_number + delta }
  end

  @impl true
  def terminate(_reason, current_number) do
    Sequence.Stash.update(current_number)
  end
end
