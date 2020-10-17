#!/usr/bin/env ruby

module Transforms
  class Html

    def initialize(extract_file_name)
      @extract_file_name = extract_file_name
    end

    def run
      extract_path = File.join(ENV["EXTRACTS_PATH"], @extract_file_name)

      plucks = read(extract_path)
        .reduce([], &method(:pluck))

      puts plucks.size
    end

    private

    def read(file_path)
      lines = []
      File.open(file_path,'r').each_with_index do |line, index|
        lines = line.gsub(/\>\</, "\>\n\<").split("\n") if index == 57
      end
      lines
    end

    def pluck(results=[], element)
      results << "" if element.include?("tabGroupTitleText")
      results << cleanse(element) if element.include?("tabGroupTitleText")
      results << cleanse(element) if element.include?("tabs")
      results << cleanse(element) if element.include?("<a class=\"clickable\" href=\"")
      results
    end

    def cleanse(element)
      element
        .then{ |el| el.gsub(/\sstyle=\".*\;\"/, "") }
        .then{ |el| el.gsub(/\sclass=\".*\"\s/, " ") }
    end

  end
end

