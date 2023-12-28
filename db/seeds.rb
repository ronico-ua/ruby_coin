# frozen_string_literal: true

reurn unless Rails.env.development?

begin
  length_of_line = `tput cols`.to_i # width of iTerm2 only
  length_of_line = [length_of_line, 120].min if length_of_line.present? # Set maximum width to 120
  length_of_line = 80 if length_of_line.nil? || length_of_line < 80 # Set minimum width to 80
rescue StandardError
  length_of_line = 80
end

LENGTH_OF_LINE = length_of_line
TAG_COUNT = 15
POST_COUNT = 50

# ==== Colorize (monkey patch) ====
class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize('1;31')
  end

  def green
    colorize('1;32')
  end

  def orange
    colorize('1;33')
  end

  def blue
    colorize('1;34')
  end

  def purple
    colorize('1;35')
  end

  def light_gray
    colorize('37')
  end
end

def pretty_print(string, color = 'light_gray', method = :puts, element = '=')
  line = if element.strip.empty?
           string.center(LENGTH_OF_LINE)
         else
           element_size = element.size
           max_element_count = [((LENGTH_OF_LINE - string.size) / (2 * element_size)).floor, 0].max
           "#{element * max_element_count} #{string} #{element * max_element_count}"
         end

  output_line = method == :puts ? "\n\n#{line.send(color.to_s)}" : "\r#{line.send(color.to_s)}"

  puts output_line if method == :puts
  print output_line unless method == :puts
end

# ==== Create User ====
if AdminUser.where(email: 'admin@example.com').blank?
  pretty_print('Creating admin user', 'orange')
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

  pretty_print('1/1', 'orange', :print, '')
end

if User.count.zero?
  pretty_print('Creating regular user', 'green')

  user = User.create(
    email: 'test@test.com',
    password: 'test@test.com',
    nickname: 'test_user',
    role: 0,
    remote_avatar_url: Faker::Avatar.image
  )
  pretty_print('1/1', 'green', :print, '')

  # ==== Create Tag ====
  if Tag.count.zero?
    pretty_print('Creating tags', 'blue')

    TAG_COUNT.times do |i|
      Tag.create(title: Faker::Hipster.word)

      pretty_print("#{i + 1}/15", 'blue', :print, '')
    end
  end

  # ==== Create Post ====
  if Post.count.zero?
    pretty_print('Creating posts', 'purple')

    POST_COUNT.times do |i|
      Post.create(title: Faker::Hipster.sentence(word_count: 1),
                  subtitle: Faker::Lorem.paragraph(sentence_count: 3,
                                                   supplemental: true,
                                                   random_sentences_to_add: 2),
                  description: Faker::Lorem.paragraph(sentence_count: 10,
                                                      supplemental: true,
                                                      random_sentences_to_add: 4),
                  status: :active,
                  user_id: user.id,
                  tag_ids: Tag.ids.sample(5),
                  created_at: Faker::Time.backward(days: 1000),
                  remote_photo_url: Faker::Avatar.image)

      pretty_print("#{i + 1}/50", 'purple', :print, '')
    end
  end

  # ==== Create translation ====
  pretty_print('Filling empty translations', 'red')

  Rake::Task['after_party:fill_translations'].invoke
  pretty_print('Task invoked', 'red', :print, '')

  # ==== Result ====
  pretty_print('All successfuly done!', 'light_gray', :puts, '')
end

# start_date = 3.years.ago
# start_date = 1.week.ago
# start_date = 1.day.ago
# end_date = Time.zone.now

# 12.times do
#   event_time = Faker::Time.between(from: start_date, to: end_date)

#   request = OpenStruct.new(params: {},
#                            referer: Faker::Internet.url,
#                            remote_ip: Faker::Internet.public_ip_v4_address,
#                            user_agent: Faker::Internet.user_agent,
#                            original_url: Rails.application.routes.url_helpers.root_url(only_path: true))

#   visit_properties = Ahoy::VisitProperties.new(request, api: nil)
#   properties = visit_properties.generate.select { |_, v| v }
#   post = Post.all.sample

#   example_visit = Ahoy::Visit.create!(properties.merge(visit_token: SecureRandom.uuid,
#                                                        visitor_token: SecureRandom.uuid,
#                                                        started_at: event_time))

#   event_properties = { slug: post.slug,
#                        title: post.title,
#                        post_id: post.id,
#                        started_at: event_time }
#   Ahoy::Event.create!(
#     visit: example_visit,
#     name: 'Viewed Post',
#     properties: event_properties,
#     time: event_time
#   )
# end
