module NewsletterHelper

  def background_color
    '#eee'
  end

  def content_padding
    '24px'
  end

  def product_padding
    '10px'
  end

  def v_padding
    '10px'
  end

  def p_padding
    '6px'
  end

  def v_margin
    '24px'
  end

  def p_margin
    '10px'
  end

  def hr_color
    '#ccc'
  end

  def hr_margin
    v_margin + ' ' + content_padding
  end

  def image_dir
    File.join(::Rails.root.to_s, '/app/assets/images/')
  end

  def local_name(file)
    ::Rails.root.join('public', 'images', file)
  end

  def render_html_module newsletter_line, prev_module_name

    #puts prev_module_name

    output_html = ''

    output_html << '<table cellpadding="5" cellspacing="0" border="0" style="border-left: #EEE ' + content_padding + ' solid;"><tr>' if prev_module_name != newsletter_line.module_name && newsletter_line.module_name == 'product'
    output_html << '</tr></table>'.html_safe if prev_module_name != newsletter_line.module_name && prev_module_name == 'product'

    if ['h1','h2','h3','h4','h5','h6'].include?(newsletter_line.module_name)

      header_name = newsletter_line.module_value.downcase.gsub(/(\s+)/, '_')
      header_text = t(header_name, :default => newsletter_line.module_value)
      header_image = 'newsletters/' + I18n.default_locale.to_s[0..1] + '/headers/' + header_name

      if FileTest.exist?(local_name(header_image + '.png'))
        header = image_tag(header_image + '.png', :alt => header_text, :style => 'border: 0 ' + background_color + ' solid; border-width: ' + v_padding + ' 0;')
      elsif FileTest.exist?(local_name(header_image + '.jpg'))
        header = image_tag(header_image + '.jpg', :alt => header_text)
      elsif FileTest.exist?(local_name(header_image + '.gif'))
        header = image_tag(header_image + '.gif', :alt => header_text)
      else
        header = header_text
        header_image = ''
      end

      header = link_to(header, newsletter_line.permalink) unless newsletter_line.permalink.blank?
      header = content_tag(newsletter_line.module_name, header, :style => 'padding-left: ' + content_padding) if header_image.blank?

      output_html << header

    elsif newsletter_line.module_name == 'hr'
      output_html << content_tag(newsletter_line.module_name, nil, :style => 'margin: ' + hr_margin + '; border: ' + hr_color + ' 1px solid; border-width: 1px 0 0 0;' )
    else

      l = {}
      if !newsletter_line.module_id.nil?
        local_name = newsletter_line.module_name + '_id'
        l[local_name.to_sym] = newsletter_line.module_id.to_i
      end

      partial = 'newsletter_mailer/' + newsletter_line.module_name

      output_html << render(:partial => partial, :locals => l)
    end

    output_html.html_safe
  end

  def render_text_module newsletter_line, prev_module_name

    output_text = ''

    if ['h1','h2','h3','h4','h5','h6'].include?(newsletter_line.module_name)
      output_text << t(newsletter_line.module_value)
      output_text << newsletter_line.module_name == 'h1' ? "\n==============================\n" : "\n------------------------------\n"
    elsif newsletter_line.module_name == 'hr'
      output_text << "\n--------------------------------------\n"
    else

      l = {}
      l[newsletter_line.module_name + '_id'] = newsletter_line.module_id.to_i unless newsletter_line.module_id.nil?

      partial = 'newsletter_mailer/' + newsletter_line.module_name

      output_text << render(:partial => partial, :locals => l)
    end

    output_text
  end

end
