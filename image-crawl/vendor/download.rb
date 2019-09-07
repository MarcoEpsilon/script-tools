require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'open-uri'
require File.join(File.dirname(__FILE__), 'save.rb')
module MarcoEpsilon
    module Download
        class Downloader
            include MarcoEpsilon::Save
            attr_reader :url
            attr_reader :saver
            attr_reader :dir
            attr_reader :filename
            def initialize(url, dir = ".", saver = nil)
                @url = url
                @saver = saver
                @dir = dir
                url =~ /^.*?([^\/]+)$/
                @filename = $1
                begin
                    Dir.mkdir(@dir) unless Dir.exists?(@dir)
                rescue => exception
                    puts "#{@dir} can't be created..."
                end
            end
            def download()
                return if File.exist?(File.join(self.dir, self.filename))
                begin
                    open(self.url) do |response|
                        data = response.read
                        self.save_to_file(self.dir, self.filename, data)
                    end
                    puts "#{self.filename} download completed"
                rescue => exception
                    puts exception.message
                end
            end
        end
    end
end