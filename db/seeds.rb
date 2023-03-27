# frozen_string_literal: true

User.create(email: 'test@test.com', password: 'test@test.com', nickname: 'test_user', role: 0) if User.all.blank?

30.times do
  Tag.create(title: Faker::Hipster.word)
end

100.times do
  Post.create(title: Faker::Hipster.sentence(word_count: 1),
              description: Faker::Lorem.paragraph(sentence_count: 5, supplemental: true,
                                                  random_sentences_to_add: 4),
              user_id: 1,
              tag_ids: Array.new(rand(5)) { rand(1...30) },
              created_at: Faker::Time.backward(days: 1000))
end
