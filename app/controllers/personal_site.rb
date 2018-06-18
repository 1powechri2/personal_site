require 'rack'

class PersonalSite
  def self.call(env)
    case_var = env["PATH_INFO"]
    case env["PATH_INFO"]
    when '/' then index
    when '/rock' then rock
    else
      check_dir(env["PATH_INFO"])
    end
  end

  def self.check_dir(file)
    if file.include?("blog")
      blog(file)
    else
      check_public_dir(file)
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
    render_view('/error.html', '404')
  end

  def self.index
    render_view('/index.html')
  end

  def self.rock
    render_view('/rock.html')
  end

  def self.blog(file)
    if File.file?("./app/views#{file}.html")
      render_view("#{file}.html")
    else
      error
    end
  end

  def self.render_static(asset)
    [200, {'Content-Type' => 'text/html'}, [File.read("./public#{asset}")]]
  end

  def self.render_view(page, code = '200')
    [code, {'Content-Type' => 'text/html'}, [File.read("./app/views#{page}")]]
  end
end
