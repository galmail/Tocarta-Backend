require "securerandom"

namespace :mewaiter do
  desc "Will generate new sids for each model"
  task :generate_sids => :environment do
    generate_sid(Menu)
    generate_sid(Section)
    generate_sid(Subsection)
    generate_sid(Dish)
    generate_sid(ModifierListSet)
    generate_sid(ModifierList)
    generate_sid(Modifier)
  end
  
  def generate_sid(model)
    puts "Generating sids for #{model}."
    model.all.each { |m|
      m.sid = SecureRandom.uuid
      m.save
    }
  end

end
