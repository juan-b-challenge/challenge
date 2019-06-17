defmodule ChallengeWeb.HealthControllerTest do
  use ChallengeWeb.ConnCase

  # setup %{conn: conn} do
  #   {:ok, conn: put_req_header(conn, "accept", "application/json")}
  # end

  test "Health check", %{conn: conn} do
    conn = post conn, "/check"
    assert json_response(conn, 200) == %{"health" => "ok"}
  end

end
