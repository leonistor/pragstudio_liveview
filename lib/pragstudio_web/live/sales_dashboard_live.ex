defmodule PragstudioWeb.SalesDashboardLive do
  use PragstudioWeb, :live_view

  alias Pragstudio.Sales

  def mount(_params, _session, socket) do
    # careful, there are 2 mounts: render html and connected socket
    if connected?(socket) do
      :timer.send_interval(3000, self(), :tick)
    end

    socket = assign_stats(socket)

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1 class="mb-5 text-dark">Sales Dashboard</h1>

    <div class="container">
      <div class="row">

        <div class="col-md">
          <div class="card">
            <p class="text-center fw-bold text-primary fs-6">New Orders</p>
            <p class="text-center fw-light" style="font-size: 5rem;"><%= @new_orders %></p>
          </div>
        </div>

        <div class="col-md">
          <div class="card">
            <p class="text-center fw-bold text-primary fs-6">Sales Amount</p>
            <p class="text-center fw-light" style="font-size: 5rem;">$<%= @sales_amount %></p>
          </div>
        </div>

        <div class="col-md">
          <div class="card">
            <p class="text-center fw-bold text-primary fs-6">Satisfaction</p>
            <p class="text-center fw-light" style="font-size: 5rem;"><%= @satisfaction %>%</p>
          </div>
        </div>

      </div>
    </div>

    <div class="text-center mt-5">
      <button class="btn btn-auto d-inline-flex flex-shrink-0
        align-items-center justify-content-center p-0 rounded-circle"
        style="width: 5rem; height: 5rem;" type="button"
        phx-click="refresh">
          <%= raw( Octicons.to_svg(:sync)) %>
      </button>
    </div>
    """
  end

  def handle_event("refresh", _, socket) do
    socket = assign_stats(socket)

    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    socket = assign_stats(socket)

    {:noreply, socket}
  end

  defp assign_stats(socket) do
    assign(socket,
      new_orders: Sales.new_orders(),
      sales_amount: Sales.sales_amount(),
      satisfaction: Sales.satisfaction()
    )
  end
end
