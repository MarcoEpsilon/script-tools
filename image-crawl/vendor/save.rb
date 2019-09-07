module MarcoEpsilon
    module Save
        def save_to_file(directory, filename, data)
            raise "Is Not Exist Directory #{directory}" unless File.directory?(directory)
            raise "Is Exist File" if File.exist?(File.join(directory, filename))
            file = File.new(File.join(directory, filename), mode:"w")
            file.binmode
            file << data
            file.close
        end
    end
end