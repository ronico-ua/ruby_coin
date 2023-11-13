# frozen_string_literal: true

LANGUAGE = {
  uk: 'Ukrainian',
  en: 'English'
}.freeze

class ChatgptService
  include HTTParty

  attr_reader :api_url, :options, :model, :message, :locale

  def initialize(params, model = 'gpt-3.5-turbo-16k')
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{ENV.fetch('CHAT_GPT_KEY') { nil }}"
      }
    }
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @model = model
    @message = params[:input_data]
    @locale = params[:locale]
  end

  def call
    choose_translation_language(locale)

    if message.length > 16_384
      sections = separated_content(message)
      translated_responses = Concurrent::Hash.new

      threads = sections.each_with_index.map do |section, index|
        Thread.new do
          translated_responses[index] = translate(section)
        end
      end

      threads.each(&:join)

      translated_responses = translated_responses.sort.to_h
      joined_response = translated_responses.values.join

    else
      joined_response = translate(message)
    end

    joined_response
  end

  def translate(section)
    body = {
      model:,
      messages: [
        {
          role: 'system',
          content: 'You are now using the ChatGPT API to translate the provided HTML content ' \
                   "from #{@input_locale} into #{@output_locale} while preserving its structure."
        },
        {
          role: 'user',
          content: section
        },
        {
          role: 'assistant',
          content: "Translate the provided HTML content from #{@input_locale} into " \
                   "#{@output_locale} while preserving its structure."
        }
      ]
    }

    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 999)
    raise response['error']['message'] unless response.code == 200

    response['choices'][0]['message']['content']
  end

  class << self
    def call(message, model = 'gpt-3.5-turbo-16k')
      new(message, model).call
    end
  end

  private

  def choose_translation_language(locale)
    @input_locale = LANGUAGE[locale.to_sym]

    @output_locale = locale == 'en' ? LANGUAGE[:uk] : LANGUAGE[:en]
  end

  def separated_content(message)
    doc = Nokogiri::HTML(message)

    sections = []

    current_section = ''

    doc.css('h1, h2, h3, h4, h5, h6').each do |heading|
      section_content = heading.to_html
      current_node = heading

      while (current_node = current_node.next_element)
        break if /h[1-6]/i.match?(current_node.name)

        section_content += current_node.to_html

        # Check if adding the current content would exceed the maximum size
        next unless section_content.length >= 16_384

        sections << current_section
        current_section = section_content
        break
      end

      current_section += section_content
    end

    sections << current_section unless current_section.empty?

    sections
  end
end
