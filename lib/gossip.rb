require "pry"
require "csv"

class Gossip

	attr_accessor :author, :content

	def initialize(author,content)
		@author = author
		@content = content
	end

	def save
		CSV.open("./db/gossip.csv", "ab") do |csv|
		    csv << [@author, @content]
		end
	end

	def self.all
		all_gossip = []
	  	CSV.parse(File.open("db/gossip.csv", "r+").read).each do |line|
	  		one_gossip = Gossip.new(line[0], line[1])
	  		all_gossip << one_gossip 
	  	end
		return all_gossip
	end

	def self.find(id)
		self.all[id.to_i]
	end

	def self.edit
		gossip_array = self.all
		target_index = @view.kill_gossip(gossip_array)
		gossip_array.delete_at(target_index)
		File.write("db/gossip.csv", (""), mode: "w")
		gossip_array.each { |gossip| gossip.save_gossip }
	end


end
