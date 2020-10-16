#!/usr/bin/env ruby

ROOT_PATH = File.expand_path(ENV["ROOT_PATH"])
EXTRACTS_PATH = File.join(ROOT_PATH, ENV["EXTRACTS_PATH"])
TRANSFORMS_PATH = File.join(ROOT_PATH, ENV["TRANSFORMS_PATH"])
LOADS_PATH = File.join(ROOT_PATH, ENV["LOADS_PATH"])

# entry point
def main
  extracted_path = File.join(EXTRACTS_PATH, "export.2020-10-15.html")
  transformed_path = File.join(TRANSFORMS_PATH, "export.2020-10-15.html")

  plucks = []

  File.open(extracted_path,'r').each_with_index do |line, index|
    # puts "#{index + 1}: #{line.size}"

    if index == 57 then
      lines = line.gsub(/\>\</, "\>\n\<").split("\n")

      plucks = lines.reduce([]) do |results, line|
        results << "" if line.include?("tabGroupTitleText")
        results << clean_element(line) if line.include?("tabGroupTitleText")
        results << clean_element(line) if line.include?("tabs")
        results << clean_element(line) if line.include?("<a class=\"clickable\" href=\"")
        results
      end
    end
  end

end

#
# helpers
#

def read(file_path)
  File.open(extracted_path,'r').each_with_index do |line, index|

    if index == 57 then
      lines = line.gsub(/\>\</, "\>\n\<").split("\n")

      plucks = lines.reduce([]) do |results, line|
        results << "" if line.include?("tabGroupTitleText")
        results << clean_element(line) if line.include?("tabGroupTitleText")
        results << clean_element(line) if line.include?("tabs")
        results << clean_element(line) if line.include?("<a class=\"clickable\" href=\"")
        results
      end
    end

  end
end

def transform(lines)
  lines.reduce([]) do |results, line|
    results << "" if line.include?("tabGroupTitleText")
    results << clean_element(line) if line.include?("tabGroupTitleText")
    results << clean_element(line) if line.include?("tabs")
    results << clean_element(line) if line.include?("<a class=\"clickable\" href=\"")
    results
  end
end

def save(file_path, plucks)
  File.open(transformed_path,'a') do |file|
    plucks.each{ |line| file.puts(line) }
  end
end

#
# run script
#
main()

