require_relative './version.rb'
require 'json'
require 'rest-client'

require 'pry'
class BudtenderCli::Prescription 
    attr_accessor :id, :name, :desc
    attr_reader :rating, :notes 
    # key = "CW3HtIO"
    # BASE_URL = "strainapi.evanbusse.com/#{key}"
    # API_KEY = "CW3HtIO"
    # "pick an effect"
    # set user input to arg for instantiating object 
    @@prescriptions = []
    def initialize(input) #one of these args are going to be user input
        effect = input 
        hash = get_random_strain_by_effect(effect)
        attr_setter(hash)
        @notes = "You did not enter any notes for this prescription"
        @rating = "You did not rate this prescription"
        
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
    def get_random_strain_by_effect(effect) # this is going to be user input !!!! the arg will be user input # still undecided about querying all effects and then letting that be input options 
        key = "CW3HtIO"
        url = "strainapi.evanbusse.com/#{key}/strains/search/effect/#{effect}"
        response = RestClient.get(url)
        results = JSON.parse(response)
        
        selected_strain = results.shuffle.first
    
        hash = {"id"=>"" , "name"=>"", "desc"=>""}
        hash["id"] = selected_strain["id"]
        hash["name"] = selected_strain["name"]
        id = hash["id"]
        hash[:desc] = query_description_by_id(("#{id}").to_i)
        hash 
    end 
    def query_description_by_id(id)
        key = "CW3HtIO"
        url  = "strainapi.evanbusse.com/CW3HtIO/strains/data/desc/#{id}"
        response = RestClient.get(url)
        results = JSON.parse(response)
        description = results["desc"]
        #The above would return the {desc=>} which will be a paragraph that I can only retrieve from this specific api call. The first call only returns [{id=>, name=>, spcies=>, effect}... ]
    end 
    def self.view_prescriptions_by_rating(input) #input here == rating 
        @@prescriptions.select {|prescription| puts "Id No. #{prescription.id}\nName: #{prescription.name}\nDescription: #{prescription.desc}\nNotes: #{prescription.notes}\nRating: #{prescription.rating}" if prescription.rating == input}
        #binding.pry
    end 
    def self.view_prescriptions 
        @@prescriptions
    end 
    def self.clear_prescriptions
        @@prescriptions.clear 
    end 
    def self.query_effects
        key = "CW3HtIO"
        url = "strainapi.evanbusse.com/#{key}/searchdata/effects"
        response = RestClient.get(url)
        results = JSON.parse(response)
        effects = results 
        # all_effects = effects.collect do |effect|
        #     effect.each do |k,v| 
        #         puts "#{v}"
        #     end 
        # end 
    end
end 
prescription = BudtenderCli::Prescription.new("relaxed")
#binding.pry
# binding.pry
# prescription = BudtenderCli::Prescription.new("relaxed")
# prescription 
# binding.pry 
