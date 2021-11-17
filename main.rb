require 'httparty'
require 'json'

def deep_to_json(h)
    h.transform_values{|v| v.is_a?(Hash) ? deep_to_json(v) : v}.to_json
end

class Repo
    attr_accessor :author, :name

    def initialize(repo_author, repo_name)
        @author = repo_author
        @name = repo_name
    end

    def url() 
        return "https://api.github.com/repos/#{@author}/#{@name}/languages"
    end
end

def main()
    puts "---------------------------------------"
    puts " "
    puts "  Welcome to Characters Repo Tool"
    puts " "
    puts "---------------------------------------"
    puts " "
    puts " ENG - There is a project that shows"
    puts " how much you used a characters of code in"
    puts " your project"
    puts " "
    puts " PL - Jest projekt który pokazuje ile"
    puts " znaków kodu użyłeś w swoim projekcie"
    puts " "
    print "Enter the author of the repository on github you want to check: "
    repo_author = gets().chomp
    print "Enter the name of the repository on github you want to check: "
    repo_name = gets().chomp

    repo = Repo::new(repo_author, repo_name)

    url = repo.url()
    response = HTTParty.get(url)
    response.parsed_response

    if response.message == "Not Found"
        puts "Unknown Author or Repo name..."
        exit 0
    else
        puts "\n"
        puts response
    end
end

main()
