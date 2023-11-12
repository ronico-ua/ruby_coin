# frozen_string_literal: true

class ChatgptService
  include HTTParty

  attr_reader :api_url, :options, :model, :message

  def initialize(message, model = 'gpt-3.5-turbo')
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{ENV.fetch('CHAT_GPT_KEY') { nil }}"
      }
    }
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @model = model
    @message = message
  end

  def call
    prompt = 'Translate it into English from Ukrainian with saving html structure and return in text format.  ' \
             "All code blocks you must put inside tag <pre class='language-ruby' " \
             "contenteditable='false' data-mce-highlighted='true' data-mce-selected='1'>Code block here</pre> " \
             "and also return as text: #{message}"

    body = {
      model:,
      messages: [{ role: 'user', content: prompt }]
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 10)
    raise response['error']['message'] unless response.code == 200

    response['choices'][0]['message']['content']
  end

  class << self
    def call(message, model = 'gpt-3.5-turbo')
      new(message, model).call
    end
  end
end
