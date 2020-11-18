defmodule ScreenerLiveWeb.VideoController do
  use ScreenerLiveWeb, :controller

  alias ScreenerLive.Screenings
  alias ScreenerLive.Screenings.Video
  alias ScreenerLive.Accounts
  alias ScreenerLiveWeb.UserAuth

  require IEx

  def edit(conn, _params) do
    render(conn, "edit.html")
  end

  def index(conn, _params) do
    videos = Screenings.list_videos_by_user_id(user(conn).id)
    render(conn, "index.json", videos: videos)
  end

  def create(conn, %{"video" => video_params}) do
    video_params = Map.put(video_params, "user_id", user(conn).id)
    with {:ok, %Video{} = video} <- Screenings.create_video(video_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.video_path(conn, :show, video))
      |> render("show.json", video: video)
    end
  end

  def show(conn, %{"id" => id}) do
    video = Screenings.get_video!(id)
    with :ok <- Bodyguard.permit(Screenings, :read_video, user(conn), video) do
      render(conn, "show.json", video: video)
    end
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Screenings.get_video!(id)

    with :ok <- Bodyguard.permit(Screenings, :write_video, user(conn), video),
      {:ok, %Video{} = video} <- Screenings.update_video(video, video_params) do
        render(conn, "show.json", video: video)
    end
  end

  def delete(conn, %{"id" => id}) do
    video = Screenings.get_video!(id)

    with :ok <- Bodyguard.permit(Screenings, :write_video, user(conn), video),
      {:ok, %Video{}} <- Screenings.delete_video(video) do
        send_resp(conn, :no_content, "")
    end
  end

  defp user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
