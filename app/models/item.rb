class Item < ApplicationRecord
  belongs_to :supplier_detail, optional: true
  validates :code, presence: true
  validates :code, uniqueness: true
  has_paper_trail

  after_save :sync_state

  has_many :stock_checks, inverse_of: :item

  state_machine initial: :out_of_stock do
    event :enter do
      transition out_of_stock: :in_stock
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

    def total_count
      sum(:quantity)
    end

    def total_value
      all.map(&:value).sum
    end
  end

  def value
    price.to_f * quantity
  end

  def change_quantity!(increase)
    if increase
      self.quantity += 1
    else
      self.quantity -= 1
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

  private

  def sync_state
    if quantity == 0
      dispatch
    else
      enter
    end
  end
end
