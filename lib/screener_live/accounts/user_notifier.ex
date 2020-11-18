defmodule ScreenerLive.Accounts.UserNotifier do
  use Bamboo.Phoenix, view: ScreenerLiveWeb.EmailView
  alias ScreenerLive.Mailer
 
  @from "no-reply@screener.com"
  
  defp deliver(%Bamboo.Email{} = email, later \\ false) do
    case later do  
      true -> Mailer.deliver_now(email)
      false -> Mailer.deliver_later(email)
    end    
    {:ok, %{to: email.to, body: email.html_body}}
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    base_email()
    |> to(user.email)
    |> subject("An account was created. Confirm your email.")
    |> assign(:user, user)
    |> assign(:url, url)
    |> render("confirmation_instructions.html")
    |> deliver()
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    base_email()
    |> to(user.email)
    |> subject("Reset the password to your account")
    |> assign(:user, user)
    |> assign(:url, url)
    |> render("reset_instructions.html")
    |> deliver()
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    deliver(user.email, """

    ==============================

    Hi #{user.email},

    You can change your email by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end

  defp base_email() do
    new_email()    
    |> from(@from)  
  end
end
