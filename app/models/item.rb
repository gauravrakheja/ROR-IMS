class Item < ApplicationRecord
  belongs_to :supplier_detail, optional: true
  validates :code, :description, presence: true
  validates :code, uniqueness: true
  has_paper_trail

  state_machine initial: :out_of_stock do
    event :order do
      transition out_of_stock: :ordered
    end

    event :receive do
      transition ordered: :in_stock
    end

    event :dispatch do
      transition in_stock: :out_of_stock
    end
  end

  class << self
    def available_events
      state_machine.events.keys
    end

    def available_states
      state_machine.states.keys
    end
  end

  def change_quantity!(increase)
    if increase
      self.quantity -= 1
    else
      self.quantity += 1
    end
    save
  end

  def event_changes
    versions.flat_map do |version|
      version.changeset.flat_map do |attribute, values|
        if attribute == "state"
          values.map(&:humanize).join(" to ") + " on #{version.created_at.strftime("%d/%m/%Y")}"
        end
      end
    end.compact
  end
end
