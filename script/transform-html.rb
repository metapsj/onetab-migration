#!/usr/bin/env ruby

ROOT_PATH = File.expand_path(ENV["ROOT_PATH"])
EXTRACTS_PATH = File.join(ROOT_PATH, ENV["EXTRACTS_PATH"])
TRANSFORMS_PATH = File.join(ROOT_PATH, ENV["TRANSFORMS_PATH"])
LOADS_PATH = File.join(ROOT_PATH, ENV["LOADS_PATH"])

# entry point
def main
  extracted = File.join(EXTRACTS_PATH, "export.2020-10-15.html")
  transformed = File.join(TRANSFORMS_PATH, "export.2020-10-15.html")

  File.open(extracted,'r').each_with_index do |line, index|
    puts "#{index + 1}: #{line.size}"

    if index == 57 then
      lines = line.gsub(/\>\</, "\>\n\<").split("\n")

      plucks = lines.reduce([]) do |results, line|
        results << "" if line.include?("tabGroupTitleText")
        results << clean_element(line) if line.include?("tabGroupTitleText")
        results << clean_element(line) if line.include?("tabs")
        results << clean_element(line) if line.include?("<a class=\"clickable\" href=\"")
        results
      end

      strips = []

      puts
      plucks.each{ |line| puts line }
      puts "plucks: #{plucks.size}"
      puts
    end

  end
end

#
# helpers
#
def clean_element(line)
  strip_class(strip_style(line))
end

def strip_style(line)
  line.gsub(/\sstyle=\".*\;\"/, "")
end

def strip_class(line)
  line.gsub(/\sclass=\".*\"\s/, " ")
end

def strip_id(line)
  line.gsub(/\sid=\".*\"/, "")
end

#
# run script
#
main()

