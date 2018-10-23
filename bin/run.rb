require_relative '../config/environment'

c1 = Character.find_by(name: "Chett")
c2 = Character.find_by(name: "YuLi")

s1 = Spell.create(name: "A cool spell")
s2 = Spell.create(name: "Hocus Pocus")

sp1 = Spellbook.create(character_id: c1.id, spell_id: s1.id)
sp2 = Spellbook.create(character_id: c2.id, spell_id: s2.id)

binding.pry
0
