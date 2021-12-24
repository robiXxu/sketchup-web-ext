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
      self.createDefault
      self.load_config
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

  def self.configFolder
    folder = "webExt"
    if mac?
      "/tmp/#{folder}"
    else
      "#{ENV['tmp']}\\#{folder}"
    end
  end

  def self.configFile
    fileName = "config.json"
    if mac?
      "#{self.configFolder}/#{fileName}"
    else
      "#{self.configFolder}\\#{fileName}"
    end
  end

  def self.generateDefaultJson
    defaultHash = {
      :url => "https://www.google.com",
      :width => 1920,
      :height => 1000,
      :center => true,
      :style => "dialog",
    }
    JSON.generate(defaultHash)
  end

  def self.createDefault
    if !Dir::exists?(self.configFolder)
      Dir.mkdir self.configFolder
    end
    if !File::exists?(self.configFile)
      f = File.new(self.configFile, "w")
      f.puts(self.generateDefaultJson.to_s)
      f.close
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
