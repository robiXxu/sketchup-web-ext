require 'sketchup.rb'
require 'extensions.rb'

module SketchupWebExt
  unless file_loaded?(__FILE__)
    ex = SketchupExtension.new('SketchUp Web Ext', 'sketchup_web_ext/main')
    ex.description = 'SketchUp Web Ext - made for testing web apps under sketchup'
    ex.version     = '1.0.0'
    ex.copyright   = 'Robert Schiriac'
    ex.creator     = 'Robert Schiriac'
    Sketchup.register_extension(ex, true)
    file_loaded(__FILE__)
  end
end
