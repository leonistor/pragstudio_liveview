# Pragstudio

LiveView Course

https://pragmaticstudio.com/courses/phoenix-liveview

## SVG Icons

https://icons.theforgesmith.com/

## CSS vars SVG

https://frontstuff.io/multi-colored-svg-symbol-icons-with-css-variables

## Tips

Debug sockets: `liveSocket.enableDebug();`

Raw HTML (unquoted): `<%= raw(Octicons.to_svg(:sync)) %>`

Rendering a LiveView on a Non-LiveView Page: `<%= live_render(@conn, LiveViewStudioWeb.CountdownTimerLive) %>`
