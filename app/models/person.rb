class Person < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :players
  has_many :sponsors
  has_many :tournament_organizers
  has_many :golf_course_organizers
  has_many :credit_cards
  accepts_nested_attributes_for :address

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :dob, presence: true
  validates :phone, presence: true, format: { with: /(\A[0-9]{3}-[0-9]{3}-[0-9]{4}\z)|(\A[0-9]{10}\z)/,
		message: "Invalid phone number"}

  validates :user, presence: true
  validates :address, presence: true

  # Used for uploading images
  has_attached_file :image, default_url: "/images/default_profile_pic.jpg"
  validates_attachment :image,
		content_type: { content_type: ["image/jpeg", "image/jpg", "image/gif", "image/png"] }

  after_validation :cleanup

  protected
  def cleanup
    self.firstname = self.firstname.strip
    self.lastname = self.lastname.strip
    if self.phone =~ /\A[0-9]{10}\z/
      self.phone = self.phone[0..2]+'-'+self.phone[3..5]+'-'+self.phone[6..9]
    end
  end

end
