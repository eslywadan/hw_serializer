# frozen_string_literal: true

# The rb code will accept the user's yml input and convert it to tsv output.

require 'yaml'

def load_yml(in_yml_file)
  YAML.safe_load(File.read(in_yml_file))
end

def convert_to_tsv(yml_data)
  content = []
  content.append("#{yml_data[0].keys.reduce { |l, r| "#{l}\t#{r}" }}\n")
  yml_data.size.times { |i| content.append("#{yml_data[i].values.reduce { |l, r| "#{l}\t#{r}" }}\n") }
  content
end

def write_tsv(tsv_data, out_tsv_file)
  File.open(out_tsv_file, 'w') { |file| tsv_data.map { |line| file << line.to_s } }
end

yml_data = load_yml(ARGV[0])
tsv_data = convert_to_tsv(yml_data)
write_tsv(tsv_data, ARGV[1])
