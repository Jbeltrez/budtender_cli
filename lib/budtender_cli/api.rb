require_relative './version.rb'
require 'json'
require 'rest-client'

class BudtenderCli::Api

   
    def self.get_random_strain_by_effect(effect) 
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
    def self.query_description_by_id(id)
        key = "CW3HtIO"
        url  = "strainapi.evanbusse.com/CW3HtIO/strains/data/desc/#{id}"
        response = RestClient.get(url)
        results = JSON.parse(response)
        description = results["desc"]
        
    end 
end 