# frozen_string_literal: true

class String
  def green
    "\e[1;32m#{self}\e[0m"
  end
end

# ==== Create User ====

if User.first.blank?
  puts "\n===== Creating user ======".green

  user = User.create(
    email: 'test@test.com',
    password: 'test@test.com',
    nickname: 'test_user',
    role: 0,
    remote_avatar_url: Faker::Avatar.image
  )
  print 'Done'.green

  # ==== Create Tag ====

  puts "\n===== Creating tags ======".green

  15.times do |i|
    Tag.create(title: Faker::Hipster.word)

    print "\r#{i + 1}/15".green
  end

  # ==== Create Post ====

  puts "\n===== Creating posts ======".green

  50.times do |i|
    title = Faker::Hipster.sentence(word_count: 1)
    Post.create(title:,
                subtitle: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true,
                                                 random_sentences_to_add: 2),
                description: Faker::Lorem.paragraph(sentence_count: 10, supplemental: true,
                                                    random_sentences_to_add: 4),
                status: :active,
                user_id: user.id,
                tag_ids: Tag.ids.sample(5),
                slug: title.parameterize,
                created_at: Faker::Time.backward(days: 1000),
                remote_photo_url: Faker::Avatar.image)

    print "\r#{i + 1}/50".green
  end

  # ==== Create translation ====

  puts "\n===== Filling empty translations ======".green

  Rake::Task['after_party:fill_translations'].invoke

  puts 'Done'.green
end
