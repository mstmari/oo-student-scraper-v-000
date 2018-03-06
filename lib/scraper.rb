require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

      doc = Nokogiri::HTML(open(index_url))
      scraped_students_array = []

      doc.css(".student-card a").each do |i|

        student = {name: i.css(".student-name").text,
          location: i.css("p.student-location").text,
          profile_url: i.attr("href")}
          scraped_students_array.push(student)
        end
        scraped_students_array
      end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))
      student_profile = {}
        social_links = []
        nodeset = doc.css('a[href]')
        urls = nodeset.map {|element| element["href"]}

          student_profile = {
          twitter: urls[1],
          linkedin: urls[2],
          github: urls[3],
          blog: urls[4],
          }


        student_profile[:profile_quote] = doc.css(".profile_quote").text
        student_profile[:bio] = doc.css("bio-content content-holder").text
        student_profile[:education] = doc.css("education-content content-holder").text


        binding.pry
end


end
