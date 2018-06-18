require 'rack'
require 'pry'

class PersonalSite
  def self.call(env)
    case env["PATH_INFO"]
    when '/' then index
    when '/rock' then rock
    # when env["PATH_INFO"].includes?('blog') then blog
    else
      check_public_dir(env["PATH_INFO"])
    end
  end

  def self.check_public_dir(file)
    if File.file?("./public#{file}")
      render_static(file)
    else
      error
    end
  end

  def self.error
    render_view('error.html', '404')
  end

  def self.index
    render_view('index.html')
  end

  def self.rock
    render_view('rock.html')
  end

  def blog
    render_view()
  end

  def self.render_static(asset)
    [200, {'Content-Type' => 'text/html'}, [File.read("./public#{asset}")]]
  end

  def self.render_view(page, code = '200')
    [code, {'Content-Type' => 'text/html'}, [File.read("./app/views/#{page}")]]
  end
end
