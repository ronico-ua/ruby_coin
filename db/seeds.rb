# frozen_string_literal: true

if User.first.blank?
  user = User.create(
    email: 'test@test.com',
    password: 'test@test.com',
    nickname: 'test_user',
    role: 0,
    remote_avatar_url: Faker::Avatar.image
  )

  15.times do
    Tag.create(title: Faker::Hipster.word)
  end

  50.times do
    Post.create(title: Faker::Hipster.sentence(word_count: 1),
                subtitle: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true,
                                                 random_sentences_to_add: 2),
                description: Faker::Lorem.paragraph(sentence_count: 10, supplemental: true,
                                                    random_sentences_to_add: 4),
                status: :active,
                user_id: user.id,
                tag_ids: Tag.ids.sample(5),
                created_at: Faker::Time.backward(days: 1000),
                remote_photo_url: Faker::Avatar.image)
  end
end
