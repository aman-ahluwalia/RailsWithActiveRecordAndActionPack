class Profile < ActiveRecord::Base
  belongs_to :user

  GENDERS = ['male', 'female']

  validate :first_or_last_null_but_not_both
  validates_inclusion_of :gender, :in => GENDERS
  validate :male_cant_have_first_name_sue

  def first_or_last_null_but_not_both
  	if first_name.nil? && last_name.nil?	
  		errors.add(:first_name, "Both first and second name together cant be null.")
  	end
  end
  def male_cant_have_first_name_sue
  	if first_name == "Sue" and gender == 'male'
  		errors.add(:gender, "First name cant be Sue, if the gender is male ;) ")
  	end
  end

  def self.get_all_profiles min, max
    Profile.where("birth_year BETWEEN :min_age AND :max_age", min_age: min, max_age: max).order(birth_year: :asc)
  end
end
