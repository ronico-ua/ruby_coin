# frozen_string_literal: true

User.create(email: 'test@test.com', password: 'test@test.com', nickname: 'test_user', role: 0) if User.all.blank?

15.times do
  Tag.create(title: Faker::Hipster.word)
end

100.times do
  Post.create(title: Faker::Hipster.sentence(word_count: 1),
              subtitle: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true,
                                               random_sentences_to_add: 2),
              description: Faker::Lorem.paragraph(sentence_count: 10, supplemental: true,
                                                  random_sentences_to_add: 4),
              status: :active,
              user_id: 1,
              tag_ids: Array.new(rand(5)) { rand(1...15) },
              created_at: Faker::Time.backward(days: 1000))
end
