require File.join(File.dirname(__FILE__), 'download.rb')
module MarcoEpsilon
    module Expand
        include MarcoEpsilon::Download
        MORE_KIND = ["Card", "ViewAll"]
        def click_more(browser)
            elements = browser.elements(tag_name:"div", class:MORE_KIND)
            elements[1].click
        end
        def scroll_more(browser)
            browser.execute_script("window.scrollBy(0, 1500);")
        end
        def collect(browser)
            srcs = []
            figures = browser.figures()
            figures.each do |figure|
                figure.children.each do |child|
                    src = child.attribute_values[:src]
                    srcs << src if src && src =~ /(https|http):\/\/(.*).jpg/
                end
            end
            return srcs
        end
        def downloads(browser, dir, count)
            click_more(browser)
            count.times do
                scroll_more(browser)
                srcs = collect(browser)
                srcs.each do |src|
                    downloader = Downloader.new(src, dir)
                    downloader.download()
                end
            end
        end
    end
end
