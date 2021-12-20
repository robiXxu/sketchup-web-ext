require 'sketchup.rb'
require 'json'

module SketchupWebExt

  def self.load_config
    if File::exists?(self.configFile)
      configHandler = File.open(self.configFile, "r")
      configData = configHandler.read
      configJson = JSON.parse(configData)
      return configJson
    else
      UI.messagebox("Failed to read #{self.configFile}. Please create the file with the following content '{ URL: \"<url_here>\"}'")
      return nil
    end
  end

  def self.getHtmlDialogStyle(style)
    case style
    when "dialog"
      UI::HtmlDialog::STYLE_DIALOG
    when "window"
      UI::HtmlDialog::STYLE_WINDOW
    when "utility"
      UI::HtmlDialog::STYLE_UTILITY
    else
      UI::HtmlDialog::STYLE_DIALOG
    end
  end

  def self.launch_webapp(config)
    dialog = UI::HtmlDialog.new({
      :dialog_title => "Webapp",
      :preferences_key => "com.web.ext",
      :scrollable => true,
      :resizable => true,
      :width => config["width"].to_i || 1280,
      :height => config["height"].to_i || 900,
      :left => 100,
      :top => 100,
      :center => config["center"] || false,
      :min_width => 50,
      :min_height => 50,
      :max_width => 9999,
      :max_height => 9999,
      :style => self.getHtmlDialogStyle(config["style"])
    })
    dialog.set_url(config["url"])
    dialog.show
  end

  def self.mac?
    (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def self.configFile
    fileName = "config.json"
    if self.mac?
      "/tmp/webExt/#{fileName}"
    else
      "%TEMP%/webExt/#{fileName}"
    end
  end


  unless file_loaded?(__FILE__)
    config = self.load_config
    unless config.nil?
      menu = UI.menu('Extensions')
      menu.add_item('Launch Webapp') {
        self.launch_webapp(config)
      }
      file_loaded(__FILE__)
    end
  end

end
