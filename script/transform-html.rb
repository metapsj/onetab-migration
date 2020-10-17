#!/usr/bin/env ruby

require './lib/transforms/html'

Transforms::ExportHtml.new("export.2020-10-15.html").run

