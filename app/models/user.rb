 class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
  before_destroy :remove_teacher_from_courses
  default_scope -> { order(name: :asc) }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\- ]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  enum role: %i[student teacher admin]
  after_initialize :set_default_role, if: :new_record?
  has_many :student_course_relationships
  has_many :courses, through: :student_course_relationships

  class << self
  # Returns the hash digest of the given string.
  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Search for a user.
  def search(search)
    query = if Rails.env.development?
              'name like ?'
            else
              'name ilike ?'
            end
    User.where(query, "%#{search}%")
  end

  # Returns a random token.
  def new_token
    SecureRandom.urlsafe_base64
  end
end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgest a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account.
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # Sends an activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token),
                   reset_sent_at: Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Students

  def enroll(course)
    courses << course if student?
  end

  def drop(course)
    courses.delete(course) if student?
  end

  def course_grade(course)
    if student?
      relationships = StudentCourseRelationship.where(user_id: id,
                                                      course_id: course.id)
      relationships.first.grade
    end
  end

  def course_grade_summary(course)
    grade = course_grade(course)
    "#{grade} (#{Course.letter_grade(grade)})"
  end



  def gpa
    # Make sure the student is enrolled in courses
    if courses.count > 0
      total_credits = 0
      total_value = 0
      courses.each do |course|
        value = course_grade(course) * course.credit
        total_value += value
        total_credits += course.credit
      end
      # formula: (grades * credits) / credits = gpa
      (total_value / total_credits).round(2) # round two for presentation
    else
      0
    end
  end

  # Teachers

  def teach(course)
    if teacher?
      course.teacher_id = id
      course.save!
    end
  end

  def courses_taught
    Course.where(teacher_id: id) if teacher?
  end

  # Faculty
  def faculty?
    if teacher? || admin?
      true
    else
      false
    end
  end

  private

  def downcase_email
    email.downcase!
  end

  # The default user role
  def set_default_role
    self.role ||= :student
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def remove_teacher_from_courses
    Course.where(teacher_id: id).each(&:remove_teacher)
  end
end
