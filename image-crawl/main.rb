#!/usr/bin/ruby
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require './vendor/expand.rb'
require './vendor/download.rb'
#url = "https://www.zhihu.com/question/285321190/answer/731940102"
url = "https://www.zhihu.com/question/28997505/answer/461992841"
browser = Watir::Browser.new :chrome, headless:true
browser.goto url
2.times do
    browser.execute_script("window.scrollBy(0, 250000);")
end
include MarcoEpsilon::Expand
MarcoEpsilon::Expand.downloads(browser, "./girl", 20)
browser.close