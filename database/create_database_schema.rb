require 'json'

file = File.read('./SRD5e-Monsters.json')
monsters = JSON.parse(file)

schema = "CREATE TABLE `monsters` (
  `rowid` INTEGER PRIMARY KEY,
  `name` TEXT NOT NULL UNIQUE,
  `type` TEXT NOT NULL,
  `subtype` TEXT NOT NULL,
  `swarm` BOOLEAN NOT NULL DEFAULT false,
  `size` TEXT NOT NULL,
  `cr` REAL NOT NULL,
  `xp` INTEGER NOT NULL,
  `woods_locale` BOOLEAN NOT NULL DEFAULT false,
  `dungeon_locale` BOOLEAN NOT NULL DEFAULT false,
  `magic` BOOLEAN NOT NULL DEFAULT false,
  `dragon` BOOLEAN NOT NULL DEFAULT false,
  `undeads` BOOLEAN NOT NULL DEFAULT false,
  `cultists` BOOLEAN NOT NULL DEFAULT false,
  `beasts` BOOLEAN NOT NULL DEFAULT false,
  `aberrations` BOOLEAN NOT NULL DEFAULT false,
  `underdark` BOOLEAN NOT NULL DEFAULT false,
  `elementals` BOOLEAN NOT NULL DEFAULT false,
  `woods` BOOLEAN NOT NULL DEFAULT false,
  `devils` BOOLEAN NOT NULL DEFAULT false,
  `demons` BOOLEAN NOT NULL DEFAULT false,
  `celestials` BOOLEAN NOT NULL DEFAULT false,
  `checked` BOOLEAN NOT NULL DEFAULT false
);"
inserts = [
  "INSERT INTO `monsters` (",
  "  `name`,",
  "  `type`,",
  "  `subtype`,",
  "  `swarm`,",
  "  `size`,",
  "  `cr`,",
  "  `xp`,",
  "  `woods_locale`,",
  "  `dungeon_locale`,",
  "  `magic`,",
  "  `dragon`,",
  "  `undeads`,",
  "  `cultists`,",
  "  `beasts`,",
  "  `aberrations`,",
  "  `underdark`,",
  "  `elementals`,",
  "  `woods`,",
  "  `devils`,",
  "  `demons`,",
  "  `celestials`",
  ")",
  "  VALUES"
]

last = monsters[monsters.length - 1]["name"]

types = %w{aberration beast celestial construct dragon elemental fey fiend giant humanoid monstrosity ooze plant undead}
woods_types = %w{beast dragon elemental fey humanoid plant undead}
dungeon_types = %w{aberration beast celestial construct dragon fiend giant humanoid monstrosity ooze undead}

def belongs?(group, name, type, subtype)
  case group
  when "magic"
    if type == "construct"
      return true
    end
  when "dragon"
    if type == "dragon" || name.downcase == "kobold"
      return true
    end
  when "undeads"
    if type == "undead"
      return true
    end
  when "cultists"
  when "beasts"
    if type == "beast"
      return true
    end
  when "aberrations"
    if type == "aberration"
      return true
    end
  when "underdark"
    if type == "aberration"
      return true
    end
  when "elementals"
    if type == "elemental"
      return true
    end
  when "woods"
    if ["elemental", "fey", "plant"].include? type
      return true
    end
  when "devils"
    devils = ["barbed devil", "bearded devil", "bone devil", "chain devil", "erinyes", "horned devil", "ice devil", "imp", "lemure", "pit fiend"]
    if devils.include? name.downcase
      return true
    end
  when "demons"
    demons = %w{balor dretch glabrezu hezrou marilith nalfeshnee quasit vrock}
    if demons.include? name.downcase
      return true
    end
  when "celestials"
    if type == "celestial"
      return true
    end
  end
  # If all tests above were false, then returns false by default.
  return false
end

monsters.each do |monster|
  type = monster["type"].downcase
  swarm = false
  if type.include? "swarm"
    type = type.match(/swarm of [a-z]+ ([a-z]+)s/)[1]
    swarm = true
  end

  subtype = ""
  if !monster["subtype"].nil?
    subtype = monster["subtype"]
  end

  inserts.push "    (\"#{monster["name"]}\", \"#{type}\", \"#{subtype}\", #{swarm}, \"#{monster["size"]}\", #{monster["challenge_rating"]}, #{monster["xp"]}, #{(woods_types.include?(monster["type"]) ? true : false)}, #{(dungeon_types.include?(monster["type"]) ? true : false)}, #{belongs?("magic", monster["name"], monster["type"], monster["subtype"])}, #{belongs?("dragon", monster["name"], monster["type"], monster["subtype"])}, #{belongs?("undeads", monster["name"], monster["type"], monster["subtype"])}, #{belongs?("cultists", monster["name"], monster["type"], monster["subtype"])}, #{belongs?("beasts", monster["name"], monster["type"], monster["subtype"])}, #{belongs?("aberrations", monster["name"], monster["type"], monster["subtype"])}, #{belongs?("underdark", monster["name"], monster["type"], monster["subtype"])}, #{belongs?("elementals", monster["name"], monster["type"], monster["subtype"])}, #{belongs?("woods", monster["name"], monster["type"], monster["subtype"])}, #{belongs?("devils", monster["name"], monster["type"], monster["subtype"])}, #{belongs?("demons", monster["name"], monster["type"], monster["subtype"])}, #{belongs?("celestials", monster["name"], monster["type"], monster["subtype"])})#{(monster["name"] == last)?";":","}"
end

out_file = File.open("monsters.sql", "w")
out_file.puts schema
out_file.puts
out_file.puts inserts
out_file.close
