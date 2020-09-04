require 'pry'

class BudtenderCli::Cli
    @@desired_effects = ["relaxed", "euphoric", "creative", "happy", "uplifted"]

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
               
                middle_step 
            end
        end 
    end 
        
    
    def middle_step 
        label_warning 
        sleep(1.5)
        @@current_prescription = BudtenderCli::Prescription.new(@input)
        @@current_prescription.save
     
        puts "Id No.#{@@current_prescription.id}\nName: #{@@current_prescription.name}\nDescription: #{@@current_prescription.desc}"
       
        sleep(1.5)
        notes_time
        sleep(1.5)
        rating_time
        sleep(1.5)
        final_step
    end 
    def final_step
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
   
    def label_warning
        puts "WARNING: DO NOT USE PRESCRIPTION WHILE OPERATING HEAVY MACHINERY"
    end 
  
    def notes_time 
        puts "Enter some notes for your prescription."
        user_input
        @@current_prescription.enter_notes=(@input)
    end 
    def rating_time 
        puts "Give your prescription a star rating"
        puts "1     2     3"
        
        user_input
        
        @@current_prescription.rating=("#{@input}")
        
    end 
    def view_prescriptions
       
        puts @@current_prescription.class.view_prescriptions.collect {|current_prescription| "Id No. #{current_prescription.id}\nName: #{current_prescription.name}\nDescription: #{current_prescription.desc}\nNotes: #{current_prescription.notes}\nRating: #{current_prescription.rating}\n\n" }
        final_step
    end 
    def view_prescriptions_by_rating
        puts "Enter a number to view all prescriptions with that rating"
       
        user_input
        @@current_prescription.class.view_prescriptions_by_rating(@input).collect {|current_prescription| puts "Id No. #{current_prescription.id}\nName: #{current_prescription.name}\nDescription: #{current_prescription.desc}\nNotes: #{current_prescription.notes}\nRating: #{current_prescription.rating}\n\n"}

        final_step
    end 

end 
