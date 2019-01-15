defmodule DiscussWeb.Comment do
  use DiscussWeb, :model

  @derive {Jason.Encoder, only: [:text]}

  schema "comments" do
    field :text, :string
    belongs_to :user, DiscussWeb.User
    belongs_to :topic, DiscussWeb.Topic

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text])
    |> validate_required([:text])
  end
end
