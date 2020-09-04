require_relative './version.rb'
# require 'json'
# require 'rest-client'

require 'pry'
class BudtenderCli::Prescription 
    attr_accessor :id, :name, :desc
    attr_reader :rating, :notes 

    @@prescriptions = []
    def initialize(input) 
        hash = BudtenderCli::Api.get_random_strain_by_effect(input)
        attr_setter(hash)
    end 

    def save
        @@prescriptions << self 
    end 

    def rating=(input)
        @rating = input
    end 

    def enter_notes=(input)
        @notes = input
    end 
    
    def attr_setter(hash) 
        hash.each do |k,v|
            self.send("#{k}=", v) if self.respond_to? (k)
        end 
    end 

    def self.view_prescriptions_by_rating(input) 
        @@prescriptions.select {|prescription| puts "Id No. #{prescription.id}\nName: #{prescription.name}\nDescription: #{prescription.desc}\nNotes: #{prescription.notes}\nRating: #{prescription.rating}\n\n" if prescription.rating == input}
    end 

    def self.view_prescriptions 
        @@prescriptions
    end 

    def self.clear_prescriptions
        @@prescriptions.clear 
    end 
end 
