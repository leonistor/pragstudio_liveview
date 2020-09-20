defmodule PragstudioWeb.SalesDashboardLive do
  use PragstudioWeb, :live_view

  alias Pragstudio.Sales

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_stats()
      |> assign(refresh: 1)

    if connected?(socket), do: schedule_refresh(socket)

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


    <div class="text-center mt-5 mx-auto" style="max-width: 300px;">
      <form phx-change="select-refresh">
        <label class="form-label" for="refresh">Refresh every: </label>
        <select class="form-control form-control-lg" name="refresh">
          <%= options_for_select(refresh_options(), @refresh) %>
        </select>
      </form>
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

  def handle_event("select-refresh", %{"refresh" => refresh}, socket) do
    refresh = String.to_integer(refresh)
    socket = assign(socket, refresh: refresh)
    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    socket = assign_stats(socket)
    schedule_refresh(socket)

    {:noreply, socket}
  end

  defp assign_stats(socket) do
    assign(socket,
      new_orders: Sales.new_orders(),
      sales_amount: Sales.sales_amount(),
      satisfaction: Sales.satisfaction()
    )
  end

  defp refresh_options do
    [{"1s", 1}, {"3s", 3}, {"5s", 5}, {"15s", 15}, {"30s", 30}, {"1m", 60}]
  end

  defp schedule_refresh(socket) do
    Process.send_after(self(), :tick, socket.assigns.refresh * 1000)
  end
end
