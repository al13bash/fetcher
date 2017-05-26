require 'open-uri'

class ParserService
  def initialize(parsing:)
    self.parsing = parsing
  end

  def run!
    payloads = headers.concat(links).uniq do |element|
      [element.kind, element.content]
    end

    ActiveRecord::Base.transaction do
      Payload.import(payloads, validate: true)
      parsing.completed!
    end
  end

  private

  attr_accessor :parsing

  def headers
    @_headers ||= page.css('h1, h2, h3').map do |node|
      Payload.new(
        kind: node.name,
        content: node.text,
        parsing_id: parsing.id
      )
    end
  end

  def links
    @_links ||= page.css('a').map do |node|
      Payload.new(
        kind: :link,
        content: node.attribute('href').value,
        parsing_id: parsing.id
      )
    end
  end

  def page
    @_page ||= Nokogiri::HTML(open(parsing.url))
  end
end
