module ApplicationHelper
  def local_time(time)
    time.utc.strftime('%Y/%m/%d %H:%M:%S')
  end

  def qrcode_tag(text, options = {})
    ::RQRCode::QRCode.new(text).as_svg(options).html_safe
  end
end
