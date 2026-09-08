defmodule RaffleyWeb.EstimatorLive do
  use RaffleyWeb, :live_view

  # mount
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Process.send_after(self(), :tick, 2000)
    end

    socket = assign(socket, tickets: 0, price: 3, page_title: "Estimator")

    #    IO.inspect(socket)
    IO.inspect(self(), label: "MOUNT")

    {:ok, socket}
    #    {:ok, assign(socket, tickets: 0, price: 3)}
  end

  # render
  def render(assigns) do
    IO.inspect(self(), label: "RENDER")

    ~H"""
    <Layouts.app flash={@flash}>
      <div class="estimator">
        <h1>Raffle Estimator</h1>
        <section>
          <button phx-click="add" phx-value-quantity="5">
            +
          </button>
          <div>
            {@tickets}
          </div>
          @
          <div>
            $ {@price}
          </div>
          =
          <div>
            $ {@tickets * @price}
          </div>
        </section>

        <form phx-submit="set-price">
          <label>Ticket Price:</label>
          <input type="number" name="price" value={@price} />
        </form>
      </div>
    </Layouts.app>
    """
  end

  # handle_event
  def handle_event("add", %{"quantity" => quantity}, socket) do
    IO.inspect(self(), label: "ADD")
    # tickets = socket.assigns.tickets + 1
    # socket = assign(socket, :tickets, tickets)

    # raise "exception"

    socket = update(socket, :tickets, &(&1 + String.to_integer(quantity)))

    # IO.inspect(socket)

    {:noreply, socket}
  end

  def handle_event("set-price", %{"price" => price}, socket) do
    socket = assign(socket, :price, String.to_integer(price))

    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 2000)
    {:noreply, update(socket, :tickets, &(&1 + 10))}
  end
end
