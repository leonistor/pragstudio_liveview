defmodule PragstudioWeb.SearchLive do
  use PragstudioWeb, :live_view

  alias Pragstudio.Stores

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        zip: "",
        stores: [],
        loading: false
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
        <%= if @loading, do: "readonly" %>
        class="form-control form-control-lg" />
      <button class="btn btn-primary mt-3">
        <%= raw(Octicons.to_svg(:search)) %>
      </button>
    </form>

    <%= if @loading do %>
    <div class="loading mx-auto" style="max-width: 400px;">
      <div class="lds-ripple"><div></div><div></div></div>
    </div>
    <% end %>

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
    send(self(), {:run_zip_search, zip})

    socket =
      assign(socket,
        zip: zip,
        # sequential assign!, use message run_zip_search to self
        # stores: Stores.search_by_zip(zip),
        stores: [],
        loading: true
      )

    {:noreply, socket}
  end

  def handle_info({:run_zip_search, zip}, socket) do
    case Stores.search_by_zip(zip) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No stores matching '#{zip}'")
          |> assign(stores: [], loading: false)

        {:noreply, socket}

      stores ->
        socket = assign(socket, stores: stores, loading: false)
        {:noreply, socket}
    end
  end
end
