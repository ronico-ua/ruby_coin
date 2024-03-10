# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def prepend_flash
    turbo_stream.prepend 'flash', partial: 'shared/flash'
  end

  def post_image(post)
    post.photo.url || image_url('')
  end

  def nav_tab(title, url, options = {})
    current_page = options.delete :current_page

    css_class = current_page == title ? 'text-secondary' : 'text-white'

    options[:class] = if options[:class]
                        "#{options[:class]} #{css_class}"
                      else
                        css_class
                      end

    link_to title, url, options
  end

  def currently_at(current_page = '')
    render partial: 'shared/menu', locals: { current_page: }
  end

  def full_title(page_title = '')
    base_title = 'RubyCoin'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end

  def process_link_path(link_path)
    # Для root_path замінюємо на '/', інакше - на ''
    result = link_path.match?(%r{^/(uk|en)/?$}) ? '/' : ''
    link_path.sub(%r{^/(uk|en)/?$}, result)
  end

  def active_class(link_path)
    # Ігноруємо локаль, якщо її немає в посиланні браузера
    path_locale = request.path.split('/')[1]
    checked_path = path_locale.blank? ? process_link_path(link_path) : link_path
    current_page?(checked_path) ? 'active' : ''
  end

  def switch_locale_to
    I18n.locale == :en ? :uk : :en
  end
end
