require 'net/http'
require 'json'

class Crawler
  BASE_URL = 'http://eb.vagas.com.br/pesquisa-vagas/itauunibanco.json'

  def initialize
    @jobs = []
    @logger = Logger.new('check_itau.log')
    @logger.datetime_format = '%Y-%m-%d %H:%M:%S'
  end


  def fetch(url)
    url      = URI::escape(url)
    response = Net::HTTP.get URI(url)

    JSON.parse response
  end


  def check_jobs_in(cities, page = 1)
    @cities        ||= cities
    @cities_params ||= get_cities_query_from cities

    @json = fetch("#{Crawler::BASE_URL}?#{@cities_params}&page=#{page}")

    @total_pages ||= @json['pagination']['page_count'].to_i

    @jobs.concat(@json['anuncios'])

    current_page = page

    if current_page < @total_pages
      current_page += 1
      check_jobs_in(city, current_page)
    end

    self
  end


  def then_notify(email_client)
    cities = @cities.gsub(/#/, ', ')

    if @jobs.empty?
      log "Nenhuma vaga encontrada para #{cities}"
      return
    end

    message = "<h3>Vagas em #{cities}</h3>"

    @jobs.each do |job|
      message << "<p><a href='#{job['url']}'>#{job['cargo']}</a></p>"
    end

    log "#{@jobs.size} vagas encontradas para: #{cities}."

    email_client.send message
  end


  private

  def get_cities_query_from(cities)
    cities.split('#').map{|c| "c[]=#{c}" }.join('&')
  end


  def log(message)
    @logger.info message
  end
end
