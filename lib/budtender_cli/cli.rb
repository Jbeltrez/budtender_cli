require 'pry'
class BudtenderCli::Cli
    @@desired_effects = ["relaxed", "euphoric", "creative", "happy", "uplifted"]
    # @@prescription = []
    def start 
        first_step 
    end 
                
    def first_step 
        while @input != "exit" do
            puts "Hi! Welcome to the Pharmacy Cli"
            puts "Enter a desired effect to recieve a prescription"
            puts "Or enter exit to leave the pharmacy Cli"
            @@desired_effects.each_with_index {|effect, i| puts "#{i+1}. #{effect.upcase}"}
            user_input 
            if @@desired_effects.include? @input 
                puts "middle_step"
                middle_step 
            end
        end 
    end 
        
    
    def middle_step 
        label_warning 
                sleep(1.5)
                @@prescription = BudtenderCli::Prescription.new(@input)
                @@prescription.save
                    # if @@prescription.desc == nil || ""
                    #     @@prescription.desc = "Currently no description available" 
                    # end
                puts "Id No.#{@@prescription.id}\nName: #{@@prescription.name}\nDescription: #{@@prescription.desc}"
                # puts "Id No.#{@@prescription[0].id}\nName: #{@@prescription[0].name}\nDescription: #{@@prescription[0].desc}"
                sleep(1.5)
                notes_time
                sleep(1.5)
                rating_time
                sleep(1.5)
                final_step
    end 
    def final_step
        # @input = " "
        until @input == "exit" 
            puts "What would you like to do next?"
            puts "      -----------------"
            puts "Get another prescription"
            puts "View my prescriptions"
            puts "View my precriptions by rating"
            puts "Exit pharmacy cli"
            user_input
            case @input 
                when "get another prescription"
                    first_step 
                when "view my prescriptions"
                    view_prescriptions
                when "view my prescriptions by rating"
                    view_prescriptions_by_rating
            end 
        end 
    end 

    def user_input
        @input = gets.strip.downcase
    end 
    def exit 
        # puts "Goodbye! See you soon. Have a nice day."
    end 
    def label_warning
        puts "WARNING: DO NOT USE PRESCRIPTION WHILE OPERATING HEAVY MACHINERY"
    end 
    def invalid_input
        puts "invalid input"
    end 
    def main_menu 
        greeting
    end
    def enjoy_your_prescription
        puts "Enjoy your prescription"
    end 
    def notes_time 
        puts "Enter some notes for your prescription."
        user_input
        @@prescription.enter_notes=(@input)
    end 
    def rating_time 
        puts "Give your prescription a star rating"
        puts "1     2     3"
        
        user_input
        # @@prescription[0].rating=("#{@input}")
        @@prescription.rating=("#{@input}")
        # puts "Id No.#{@@prescription[0].id}\nName: #{@@prescription[0].name}\nDescription: #{@@prescription[0].desc}\nNotes: #{@@prescription[0].notes}\nRating: #{@@prescription[0].rating}"
    end 
    def view_prescriptions
        #binding.pry
        # puts @@prescription[0].class.view_prescriptions.collect {|prescription| puts "Id No.#{prescription.id}\n#{prescription.name}\n#{prescription.desc}\n#{prescription.notes}\n#{prescription.rating}" }
        puts @@prescription.class.view_prescriptions.collect {|prescription| "Id No. #{prescription.id}\nName: #{prescription.name}\nDescription: #{prescription.desc}\nNotes: #{prescription.notes}\nRating: #{prescription.rating}\n\n" }
        final_step
    end 
    def view_prescriptions_by_rating
        puts "Enter a number to view all prescriptions with that rating"
        # binding.pry
        user_input
        @@prescription.class.view_prescriptions_by_rating(@input).collect {|prescription| puts "Id No. #{prescription.id}\nName: #{prescription.name}\nDescription: #{prescription.desc}\nNotes: #{prescription.notes}\nRating: #{prescription.rating}\n\n"}
        # puts @@prescription.class.view_prescriptions.collect {|prescription| puts "Id No.#{prescription.id}\n#{prescription.name}\n#{prescription.desc}\n#{prescription.notes}\n#{prescription.rating}" if prescription.rating == @input}
        # @@prescription[0].class.view_prescriptions_by_rating(@input)
        # puts @@prescription.class.view_prescriptions_by_rating(@input).collect do |prescription|
        # puts "Id No. #{prescription.id}\nName: #{prescription.name}\nDescription: #{prescription.desc}\nNotes: #{prescription.notes}\nRating: #{prescription.rating}"
        # end 
        final_step
    end 

end 

    # def greeting 
    #     puts "Hi! Welcome to the Pharmacy Cli"
    #     puts "Enter a desired effect to recieve a prescription"
    #     desired_effects = ["relaxed", "euphoric", "creative", "happy", "uplifted"]
    #     puts desired_effects.each_with_index {|effect, i| "#{i+1}. #{effect.upcase}"}
    #     input = gets.strip 

    #     prescription = BudtenderCli::Prescription.new(input)
    #     if prescription.desc == nil || ""
    #         prescription.desc = "Currently no description available"
    #     end
    #     puts "Id No.#{prescription.id}\nName: #{prescription.name}\nDescription: #{prescription.desc}"
    #     puts "Enter some notes for your prescription, or enter Skip to conitnue"
    #     input = gets.strip 
    #     prescription.enter_notes=(input)
    #     if prescription.desc == nil 
    #         prescription.desc = "Currently no description available"
    #     end
    #     puts "Id No.#{prescription.id}\nName: #{prescription.name}\nDescription: #{prescription.desc}\nNotes: #{prescription.notes}\n"
    #     puts "Give your prescription a rating, or enter Skip to continue"
    #     puts "1 star    2 star     3 star"


    #     input = gets.strip 
    #     prescription.rating=("#{input}")
    #     puts "Id No.#{prescription.id}\nName: #{prescription.name}\nDescription: #{prescription.desc}\nNotes: #{prescription.notes}\nRating: #{prescription.rating}"
        
    #     puts "If you would like to view all your prescriptions select View Prescriptions. If you would like to leave the pharmacy, enter exit. To recieve another prescription enter main menu."
    #     input = gets.strip 
    #     # if input == 1 star || 2 star || 3 star
    #     #     rating = input 
    #     #     prescription.class.view_prescriptions_by_rating(rating)
    #     if input == ("view prescriptions")
    #        puts prescription.class.view_prescriptions.collect {|prescription| "Id No.#{prescription.id}\n#{prescription.name}\n#{prescription.desc}\n#{prescription.notes}\n#{prescription.rating}" }
       
   
