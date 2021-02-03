defmodule ScreenerLiveWeb.Helpers.Forms do
  import Phoenix.HTML.Form, only: [datetime_select: 3]
  import Phoenix.HTML, only: [sigil_E: 2]
  require EEx

  def date_only_datetime_select(form, field, opts \\ []) do
    builder = fn b ->
      today = Timex.now()

      year = Enum.map(0..8, fn i -> today.year + i end)

      [
        ~E"<div>",
        b.(:month,
          options: 1..12,
          value: today.month,
          class: "form-select bg-charcoal-light border-0 text-ghost inline-block w-auto mr-1 "
        ),
        b.(:day,
          options: 1..31,
          value: today.day,
          class: "form-select bg-charcoal-light border-0 text-ghost inline-block w-auto mr-1"
        ),
        b.(:year,
          options: year,
          value: today.year,
          class: "form-select bg-charcoal-light border-0 text-ghost inline-block w-auto mr-1"
        ),
        ~E" <span class='text-ghost text-xs italic'>MM/DD/YYYY</span></div>",
        b.(:hour, value: 23, class: "hidden"),
        b.(:minute, value: 59, class: "hidden"),
        b.(:second, value: 59, class: "hidden")
      ]
    end

    datetime_select(form, field, [builder: builder] ++ opts)
  end

  def get_day() do
    Timex.format!(Timex.now(), "%d")
  end
end
