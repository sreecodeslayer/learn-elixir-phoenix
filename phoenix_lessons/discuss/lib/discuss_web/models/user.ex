defmodule DiscussWeb.User do
  use DiscussWeb, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :provider, :string
    field :token, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :provider, :token])
    |> validate_required([:name, :email, :provider, :token])
  end
end
