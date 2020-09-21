defmodule PragstudioWeb.SearchLive do
  use PragstudioWeb, :live_view

  alias Pragstudio.Stores

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        zip: "",
        stores: []
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1 class="mb-3 fs-5">Find a Store</h1>

    <form class="mx-auto text-center" style="max-width: 400px;"
      phx-submit="zip-search">
      <input type="text" name="zip" value="<%= @zip %>" placeholder="Zip Code"
        autofocus autocomplete="off"
        class="form-control form-control-lg" />
      <button class="btn btn-primary mt-3">
        <%= raw(Octicons.to_svg(:search)) %>
      </button>
    </form>

    <div id="search" class="py-6 mx-auto" style="max-width: 700px;">
      <div class="card-group">
          <%= for store <- @stores do %>
            <div class="card">
                <div class="first-line row">
                  <div class="name col fs-4 text-left">
                    <%= store.name %>
                  </div>
                  <div class="status col fs-3 text-right">
                    <%= if store.open do %>
                      <span class="open btn btn-success">Open</span>
                    <% else %>
                      <span class="closed btn btn-danger">Closed</span>
                    <% end %>
                  </div>
                </div>
                <div class="second-line row mt-3">
                  <div class="street col text-left">
                    <img src="images/location.svg" style="width: 3rem;">
                    <%= store.street %>
                  </div>
                  <div class="phone_number col text-right">
                    <img src="images/phone.svg">
                    <%= store.phone_number %>
                  </div>
                </div>
            </div>
          <% end %>
      </div>
    </div>
    """
  end

  def handle_event("zip-search", %{"zip" => zip}, socket) do
    socket =
      assign(socket,
        zip: zip,
        stores: Stores.search_by_zip(zip)
      )

    {:noreply, socket}
  end
end
