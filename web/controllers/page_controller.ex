defmodule PubsubStress.PageController do
  use PubsubStress.Web, :controller

  def index(conn, _params) do
    PubsubStress.Endpoint.broadcast!("rooms:lobby", "new_msg",%{
      query: "slkjfskfjslfjslf",
      location_iso_code: "124242424",
      location: "Earth",
      ts: "1234"})

    json conn, %{ok: true}
  end
end
