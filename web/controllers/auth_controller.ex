defmodule Tribes54.AuthController do
  use Tribes54.Web, :controller

  @doc """
  This action is reached via `/auth/:provider` and redirects to the OAuth2 provider
  based on the chosen strategy.
  """
  def index(conn, %{"provider" => provider}) do
    redirect conn, external: authorize_url!(provider)
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  @doc """
  This action is reached via `/auth/:provider/callback` is the the callback URL that
  the OAuth2 provider will redirect the user back to with a `code` that will
  be used to request an access token. The access token will then be used to
  access protected resources on behalf of the user.
  """
  def callback(conn, %{"provider" => provider, "code" => code}) do
    # Exchange an auth code for an access token
    token = get_token!(provider, code)

    # Request the user's data with the access token
    user = get_user!(provider, token)

    # Store the user in the session under `:current_user` and redirect to /.
    # In most cases, we'd probably just store the user's ID that can be used
    # to fetch from the database. In this case, since this example app has no
    # database, I'm just storing the user map.
    #
    # If you need to make additional resource requests, you may want to store
    # the access token as well.
    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, token.access_token)
    |> redirect(to: "/")
  end

  defp authorize_url!("google") do
    Google.authorize_url!(scope: "https://www.googleapis.com/auth/userinfo.email")
  end

  defp authorize_url!(_) do
    raise "No matching provider available"
  end

  defp get_token!("google", code) do
    Google.get_token!(code: code)
  end

  defp get_token!(_, _) do
    raise "No matching provider available"
  end

  defp get_user!("google", token) do
    {:ok, %{body: user}} = OAuth2.AccessToken.get(token, "https://www.googleapis.com/plus/v1/people/me/openIdConnect")
    %{nickname: user["given_name"], avatar: user["picture"]}
  end


end
