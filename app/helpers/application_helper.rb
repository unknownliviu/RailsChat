module ApplicationHelper
  def gravatar_for(user, opts = {})
    opts[:alt] = user.name
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 40 }}",
              opts
  end

  def apply_formatting(text)
    processed_text = text.split('').in_groups_of(100).map(&:join).join('<br>')
    processed_text =  processed_text.split(/\s+/).map {|t| t =~ /^https?:/ ? link_to(t, t) : t}.join(' ')
    urls = text.split(/\s+/).find_all { |u| u =~ /^https?:/ }
    if urls.any?
      begin
        object = LinkThumbnailer.generate(urls.first)
        [processed_text, image_tag(object.images[0].src.to_s, width: '200px', height: '100%')].join('<br>')
      rescue NoMethodError, URI::InvalidURIError
        processed_text
      end
    else
      processed_text
    end
  end
end
