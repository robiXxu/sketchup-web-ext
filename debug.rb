require 'json'

def mac?
  (/darwin/ =~ RUBY_PLATFORM) != nil
end

def configFolder
  folder = "webExt"
  if mac?
    "/tmp/#{folder}"
  else
    "#{ENV['tmp']}\\#{folder}"
  end
end
def configFile
  fileName = "config.json"
  if mac?
    "#{configFolder}/#{fileName}"
  else
    "#{configFolder}\\#{fileName}"
  end
end

def generateDefaultJson
  defaultHash = {
    :url => "https://www.google.com",
    :width => 1920,
    :height => 1000,
    :center => true,
    :style => "dialog",
  }
  JSON.generate(defaultHash)
end

def createDefault(configFile)
  if !Dir::exists?(configFolder)
    Dir.mkdir configFolder
  end
  if !File::exists?(configFile)
    puts generateDefaultJson
    f = File.new(configFile, "w")
    f.puts(generateDefaultJson.to_s)
    f.close
  end
end

def loadConfig(configFile)
  if File::exists?(configFile)
    configHandler = File.open(configFile, "r")
    configData = configHandler.read
    configJson = JSON.parse(configData)
    puts "yep #{configJson['url']}"
  else
    puts "nope"
    createDefault(configFile)
    loadConfig(configFile)
  end
end

loadConfig(configFile)

