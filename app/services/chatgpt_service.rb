# frozen_string_literal: true

LANGUAGE = {
  uk: 'Ukrainian',
  en: 'English'
}.freeze

class ChatgptService
  include HTTParty

  attr_reader :api_url, :options, :model, :message, :locale

  def initialize(params, model = 'gpt-3.5-turbo')
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
          content: message
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
    def call(message, model = 'gpt-3.5-turbo')
      new(message, model).call
    end
  end

  private

  def choose_translation_language(locale)
    @input_locale = LANGUAGE[locale.to_sym]

    @output_locale = locale == 'en' ? LANGUAGE[:uk] : LANGUAGE[:en]
  end
end
