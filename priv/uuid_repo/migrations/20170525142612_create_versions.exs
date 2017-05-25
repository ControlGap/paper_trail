defmodule PaperTrail.UUIDRepo.Migrations.CreateVersions do
  use Ecto.Migration

  def change do
    create table(:versions) do
      add :event,        :string, null: false, size: 10
      add :item_type,    :string, null: false
      add :item_id,      :binary_id
      add :item_changes, :map, null: false
      add :originator_id, references(:admins, type: :binary_id)
      add :origin,       :string, size: 50
      add :meta,         :map

      add :inserted_at,  :utc_datetime, null: false
    end

    create index(:versions, [:originator_id])
    create index(:versions, [:item_id, :item_type])
    create index(:versions, [:event, :item_type])
    create index(:versions, [:item_type, :inserted_at])
  end
end
