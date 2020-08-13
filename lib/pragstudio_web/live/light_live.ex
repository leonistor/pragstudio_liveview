defmodule PragstudioWeb.LightLive do
  use PragstudioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :brightness, 10)}
  end

  def render(assigns) do
    ~L"""
    <h1>Front Porch Light</h1>

    <svg style="--bulb-color: hsl(51, <%= @brightness %>%, 50%);" id="bulb" class="bulb-colors" viewBox="0 0 64 64" version="1.1"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink">
    <path
        d="M32,8.38c7.4,0 14.16,6 14.16,13.4c0.001,2.209 -0.546,4.384 -1.59,6.33c-1.87,3.49 -5.35,8.2 -5.35,13.83l-14.44,0c0,-5.63 -3.48,-10.34 -5.35,-13.83c-1.044,-1.946 -1.591,-4.121 -1.59,-6.33c0,-7.4 6.76,-13.4 14.16,-13.4"
        class="" fill="var(--bulb-color)" />
    <path
        d="M35.78,50.87l0,0.93c0.013,0.124 0.02,0.25 0.02,0.375c0,1.931 -1.589,3.52 -3.52,3.52c-1.931,-0 -3.52,-1.589 -3.52,-3.52c0,-0.125 0.007,-0.251 0.02,-0.375l0,-0.93"
        fill="var(--socket-color)" />
    <path
        d="M42.58,43.94c0,-1.275 -1.035,-2.31 -2.31,-2.31l-16,0c-1.275,0 -2.31,1.035 -2.31,2.31c0,1.275 1.035,2.31 2.31,2.31l16,0c1.275,0 2.31,-1.035 2.31,-2.31Z"
        fill="var(--socket-color)" />
    <path
        d="M41.31,48.56c0,-1.275 -1.035,-2.31 -2.31,-2.31l-13.47,0c-1.275,0 -2.31,1.035 -2.31,2.31c-0,1.275 1.035,2.31 2.31,2.31l13.47,-0c1.275,-0 2.31,-1.035 2.31,-2.31Z"
        fill="var(--socket-color)" />
    <path d="M22.87,21.14c0.235,-4.48 4.11,-7.975 8.59,-7.75" style="fill:none;"
        stroke-linecap="round" />
    </svg>

    <div id="light">
      <div id="meter-container">
        <div id="meter-value" style="width: <%= @brightness %>%;">
          <%= show_percent(@brightness) %>
        </div>
      </div>

      <button phx-click="off">
        Off
      </button>
      <button phx-click="down">&#x25BC;</button>

      <button phx-click="rando">&#x1F3B2;</button>

      <button phx-click="up">&#x25B2;</button>
      <button phx-click="on">
        On
      </button>

    </div>
    """
  end

  def handle_event("off", _params, socket) do
    {:noreply, assign(socket, :brightness, 0)}
  end

  def handle_event("on", _params, socket) do
    {:noreply, assign(socket, :brightness, 100)}
  end

  def handle_event("down", _params, socket) do
    {:noreply, update(socket, :brightness, &max(&1 - 10, 0))}
  end

  def handle_event("up", _params, socket) do
    {:noreply, update(socket, :brightness, &min(&1 + 10, 100))}
  end

  def handle_event("rando", _params, socket) do
    {:noreply, assign(socket, :brightness, Enum.random(0..100))}
  end

  defp show_percent(0), do: ""
  defp show_percent(value), do: "#{value}%"
end
