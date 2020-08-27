require 'pry'
class BudtenderCli::Cli
    def greeting 
        puts "Hi! Welcome to the Pharmacy Cli"
        puts "select a desired effect to recieve a prescription"
        puts "relaxed" 
        input = gets.strip 

        prescription = BudtenderCli::Prescription.new(input)
        puts "Id No.#{prescription.id}\nName: #{prescription.name}\nDescription: #{prescription.desc}"
        puts "Enter some notes for your prescription"
        input = gets.strip 
        prescription.enter_notes=(input)
        if prescription.desc == nil 
            prescription.desc = "Currently no description available"
        end
        puts "Id No.#{prescription.id}\nName: #{prescription.name}\nDescription: #{prescription.desc}\nNotes: #{prescription.notes}\n"
        puts "Give your prescription a rating"
        puts "1 star     2 star     3 star"
        input = gets.strip 
        prescription.rating=("#{input}")
        puts "Id No.#{prescription.id}\nName: #{prescription.name}\nDescription: #{prescription.desc}\nNotes: #{prescription.notes}\nRating: #{prescription.rating}"
        prescription.save 
        puts "If you would like to view your prescriptions select View Prescriptions"
        input = gets.strip 
        prescription.class.view_prescriptions


        
       
        puts "Enjoy your prescription!"
        
    end 
  
  
end 