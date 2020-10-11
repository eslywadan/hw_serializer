# frozen_string_literal: true

# The rb code will accept the user's tsv input and convert it to yaml output.
require 'yaml'
require 'csv'

def load_tsv(in_tsv_file)
  tsv_data = []
  tsv_file = CSV.open(in_tsv_file, 'r', **{ col_sep: "\t" })
  tsv_file.each do |row|
    tsv_data.append(row)
  end
  tsv_data
end

def convert_to_yaml(tsv_data)
  headers = tsv_data.shift.map(&:to_s)
  string_data = tsv_data.map { |row| row.map(&:to_s) }
  array_of_hashes = string_data.map { |row| Hash[*headers.zip(row).flatten] }
  array_of_hashes.to_yaml
end

def write_yaml(yaml_data, out_yml_file)
  File.write(out_yml_file, yaml_data) unless out_yml_file.nil?
end

tsv_data = load_tsv(ARGV[0])
yaml_data = convert_to_yaml(tsv_data)
write_yaml(yaml_data, ARGV[1])
