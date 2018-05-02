#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'

require 'erb'
require 'sass'

raw_objects = [
  {
    name: 'Dekan',
    description: 'Du dør hvis du angriber et grupperum. <br />Du dør hvis Rektor angriber dig',
    count: 8
  },
  {
    name: 'Rektor',
    description: 'Du dør hvis du angriber et grupperum. <br />Du dør hvis 5 studerende angriber dig',
    count: 4
  },
  {
    name: 'ProDekan',
    description: 'Du dør hvis du angriber et grupperum. <br />Du dør hvis Rektor, eller Dekan angriber dig',
    count: 8
  },
  {
    name: 'Skoleleder',
    description: 'Du dør hvis du angriber et grupperum. <br />Du dør hvis Rektor, Dekan, eller ProDekan angriber dig',
    count: 12
  },
  {
    name: 'Professor',
    description: 'Du dør hvis du angriber et grupperum. <br />Du dør hvis Rektor, Dekan, Skoleleder, eller ProDekan angriber dig',
    count: 16
  },
  {
    name: 'Sekretær',
    description: 'Du dør hvis Rektor, Dekan, Skoleleder, ProDekan, eller Professor angriber dig',
    count: 20
  },
  {
    name: 'PhD Stud',
    description: 'Du dør hvis du angriber et grupperum. <br />Du dør hvis Rektor, Dekan, Skoleleder, ProDekan, Professor, eller Sekretæren angriber dig',
    count: 24
  },
  {
    name: 'Grupperum',
    description: 'Du dør hvis sekretæren angriber dig. <br />Du kan ikke angribe nogen',
    count: 40
  },
  {
    name: 'Studerende',
    description: 'Du dør hvis du angriber et grupperum. <br />Du dør hvis Rektor, Dekan, ProDekan, Skoleleder, Professor, Sekretæren eller PhD Stud. angriber dig.',
    count: 96
  }
]

objects = raw_objects.reduce([]) do |n, obj|
  obj[:count].times do
    n << obj.tap { |hs| hs.delete(:count) }
  end
  n
end

styling = Sass.compile(File.read('style.scss'))

erb_output = ERB.new(File.read('index.html.erb'.freeze), nil, "<>-")
html = erb_output.result

puts html
