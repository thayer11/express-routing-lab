require 'faraday'

# This class handles JSON communication with the backend
# class FavoriteService
#   def self.create(name, id)
#     connection.post do |request|
#       request.url 'favorites'
#       request.headers['Content-Type'] = 'application/json'
#       request.body = {Title: name, imdbID: id}.to_json
#     end
#   end

#   class << self
#     private

#     def connection
#       @connection = Faraday.new(url: HOST) do |faraday|
#         faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
#       end
#     end
#   end


def connection 
	Faraday.new(url: 'http://localhost:3000') do |faraday|
		faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
end

def create_candy(name='M&M', color='green')
	connection.post do |request| 
		request.url 'candies'
		request.headers['Content-Type'] = 'application/json'
		request.body = {name: name, color: color }.to_json
	end 
end

Given(/^a candy has been created$/) do
	response = create_candy
	json_response = JSON.parse(response.body)
	@candy = json_response['id']
end

Given(/^two candies have been created$/) do
	create_candy
	create_candy('Kit-Kat', 'brown')
end


When(/^I post to create a candy$/) do
	@response = create_candy
end

When(/^I get to show a candy$/) do
	@response = connection.get "candies/#{@candy}"
end

When(/^I get to index the candies$/) do
 	@response = connection.get 'candies'
end

When(/^I put to update the candies$/) do
  	@response = connection.put do |request| 
		request.url "candies/#{@candy}/edit"
		request.headers['Content-Type'] = 'application/json'
		request.body = { id: @candy, name: "M&M", color: "blue" }.to_json
	end 
end

When(/^I delete to destroy the candies$/) do
  connection.delete "candies/#{@candy}"
end

Then(/^a candy is created$/) do
	json_response = JSON.parse(@response.body)
	expect(json_response['id']).to_not be_nil
	expect(json_response['name']).to eq 'M&M'
	expect(json_response['color']).to eq 'green'
end

Then(/^I see the candy details$/) do
	json_response = JSON.parse(@response.body)
	expect(json_response['id']).to be @candy
	expect(json_response['name']).to eq 'M&M'
	expect(json_response['color']).to eq 'green'
end

Then(/^I see all the candy details$/) do
	json_response = JSON.parse(@response.body)
	expect(json_response.class).to eq Array
	expect(json_response.size).to be >= 2 
end

Then(/^I the candy is updated$/) do
  	json_response = JSON.parse(@response.body)
	expect(json_response['id']).to be @candy
	expect(json_response['name']).to eq 'M&M'
	expect(json_response['color']).to eq 'blue'
end

Then(/^I the candy is deleted$/) do
  response = connection.get "candies/#{@candy}"  
  expect(response.body).to be_empty
end