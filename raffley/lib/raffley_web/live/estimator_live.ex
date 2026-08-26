defmodule RaffleyWeb.EstimatorLive do
    use RaffleyWeb, :live_view

    # mount
    def mount(_params, _session, socket) do
       socket = assign(socket, tickets: 0, price: 3)

       IO.inspect(socket)

       {:ok, socket}
    #    {:ok, assign(socket, tickets: 0, price: 3)}
    end

    # render
    # def render(assigns) do
    #     ~H"""
    #     <div class="estimator">
    #         <h1>Raffle Estimator</h1>
    #         <section>
    #             <div>
    #                 <%= @tickets %>
    #             </div>
    #             @
    #             <div>
    #                $ <%= @price %>
    #             </div>
    #             =
    #             <div>
    #                $ <%= @tickets * @price %>
    #             </div>
    #         </section>
    #     </div>
    #     """
    # end

    # handle_event
    def handle_event("add", %{"quantity" => quantity}, socket) do
        # tickets = socket.assigns.tickets + 1
        # socket = assign(socket, :tickets, tickets)

        socket = update(socket, :tickets, &(&1 + String.to_integer(quantity)))

        IO.inspect(socket)

        {:noreply, socket}
    end
end
