class Task < ApplicationRecord
    has_one_attached :image
    before_validation :set_nameless_name
    validates :name, presence: true
    validates :name, length: { maximum:30 }
    validate :validate_name_not_including_comma

    belongs_to :user
    has_one_attached :image do |attachable|
        attachable.variant :display, resize_to_limit: [400, 400]
      end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "name"]
    end

    private

    def validate_name_not_including_comma
        errors.add(:name, 'にカンマを含めることはできません')if name&.include?(',')
    end

    def set_nameless_name
        self.name = '名前なし' if name.blank?
    end

end
