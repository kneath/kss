require 'sinatra'
require 'kss'

get '/' do
  erb :index
end

get '/styleguide' do
  @styleguide = Kss::Parser.new('public/stylesheets')
  erb :styleguide
end

get '/inline' do
  buttons =<<-'EOS'
    /*
    Your standard form button.

    :hover    - Highlights when hovering.
    :disabled - Dims the button when disabled.

    Styleguide 1.1
    */
    button {
      padding: 5px 15px;
      line-height: normal;
      font-family: "Helvetica Neue", Helvetica;
      font-size: 12px;
      font-weight: bold;
      color: #666;
      text-shadow: 0 1px rgba(255, 255, 255, 0.9);
      border-radius: 3px;
      border: 1px solid #ddd;
      border-bottom-color: #bbb;
      background: #f5f5f5;
      filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0, startColorstr='$start', endColorstr='$end');
      background: -webkit-gradient(linear, left top, left bottom, from(#f5f5f5), to(#e5e5e5));
      background: -moz-linear-gradient(top, #f5f5f5, #e5e5e5);
      box-shadow: 0 1px 4px rgba(0, 0, 0, 0.15);
      cursor: pointer;
    }
    button:disabled {
      opacity: 0.5;
    }
  EOS
  @styleguide = Kss::Parser.new(buttons)
  erb :styleguide
end

helpers do
  # Generates a styleguide block. A little bit evil with @_out_buf, but
  # if you're using something like Rails, you can write a much cleaner helper
  # very easily.
  def styleguide_block(section, &block)
    @section = @styleguide.section(section)
    @example_html = capture{ block.call }
    @escaped_html = ERB::Util.html_escape @example_html
    @_out_buf << erb(:_styleguide_block)
  end

  # Captures the result of a block within an erb template without spitting it
  # to the output buffer.
  def capture(&block)
    out, @_out_buf = @_out_buf, ""
    yield
    @_out_buf
  ensure
    @_out_buf = out
  end
end
