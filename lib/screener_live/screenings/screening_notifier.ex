defmodule ScreenerLive.Screenings.ScreeningNotifier do
  use Bamboo.Phoenix, view: ScreenerLiveWeb.EmailView
  alias ScreenerLive.Mailer

  @from "no-reply@screener.com"

  def deliver(%Bamboo.Email{} = email, later \\ false) do
    case later do
      true -> Mailer.deliver_now(email)
      false -> Mailer.deliver_later(email)
    end

    {:ok, %{to: email.to, body: email.html_body}}
  end

  def deliver_new_screening(screening, video) do
    base_email()
    |> to(screening.recipient_email)
    |> subject("New Screener Available!")
    |> assign(:screening, screening)
    |> assign(:video, video)
    |> assign(:url, public_screening_url(screening))
    |> render("new_screening.html")
    |> deliver()
  end

  defp base_email() do
    new_email()
    |> from(@from)
  end

  defp public_screening_url(screening) do
    encoded_uuid = Base.url_encode64("bcb502b1-9b43-4fcb-b39f-86521ed2d454")
    "#{System.get_env("FRONTEND_URL")}/screenings/#{encoded_uuid}"
  end
end
