class Spell < ActiveRecord::Base
  has_many :spellbooks
  has_many :characters, through: :spellbooks

end
