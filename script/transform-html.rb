#!/usr/bin/env ruby

require './lib/transforms/html'

Transforms::Html.new("export.2020-10-15.html").run

