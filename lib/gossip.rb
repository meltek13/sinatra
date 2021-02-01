
require 'csv'

class Gossip

  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("/Users/meltek/Desktop/the_gossip_project_sinatra2/db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("db/gossip.csv").each do |ligne|
      all_gossips << Gossip.new(ligne[0], ligne[1])
     end
    return all_gossips
  end

  def self.find(id)
    return CSV.read("db/gossip.csv")[id]
  end

  def self.update(id, new_author, new_content)
    all_gossips = self.all
    all_gossips[id].author = new_author
    all_gossips[id].content = new_content
    CSV.open("./db/gossip.csv", "w") do |csv|
      all_gossips.each do |gossip|
        csv << [gossip.author, gossip.content]
      end
    end
  end
end

