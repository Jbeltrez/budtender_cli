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
        hash = query_strains_by_effect(effect)
        test_method(hash)
        @notes = ""
        @rating = ""
        
    end 
    def self.view_prescriptions 
        @@prescriptions
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
    
    def test_method(hash) 
        hash.each do |k,v|
            self.send("#{k}=", v) if self.respond_to? (k)
        end 
    end 
   
    def query_strains_by_effect(effect) # this is going to be user input !!!! the arg will be user input # still undecided about querying all effects and then letting that be input options 
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
    # def self.query_effects
    #     key = "CW3HtIO"
    #     url = "strainapi.evanbusse.com/#{key}/searchdata/effects"
    #     response = RestClient.get(url)
    #     results = JSON.parse(response)
    #     effects = results 
    #     # all_effects = effects.collect do |effect|
    #     #     effect.each do |k,v| 
    #     #         puts "#{v}"
    #     #     end 
    #     # end 
    #     binding.pry
    #     # all_effects = effects.collect do |effect|
    #     #     binding.pry
    #     #     effect.each do |k,v| 
    #     #         puts "#{v}"
    #     #     end 
    #     # end 
        
    # end 
    # def setratingwithuserinput(input)
    #     input = gets.strip 
    #     # rating=(input)
    #     rating=(input)
    # end 

          
#     def rating=(rating)

        
#         if rating != nil 
#             @rating = "#{rating} stars"
#         end       
#         #     rating = "3 stars"
#         # end 
#         #this rating property will be equal to "not yet rated" if no rating has been set. The rating should
#         # have a new value of a number 1..3 that will be the new value of the rating property once set 
#         #
#     end 
# end 
end 

# prescription = BudtenderCli::Prescription.new("relaxed")
# prescription 
# binding.pry 
