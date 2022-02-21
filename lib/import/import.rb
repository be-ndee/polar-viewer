require "#{File.dirname(__FILE__)}/../../lib/polar/lib/polar_data_parser"

def get_directory()
  return "#{File.dirname(__FILE__)}/../../synch/U/0"
end

def get_date_directory(date)
  return "#{self.get_directory()}/#{date}/E"
end

def get_time_directory(date, time)
  return "#{self.get_date_directory(date)}/#{time}"
end

def is_valid_date(date)
  return /^\d{8}$/ =~ date
end

def is_valid_time(time)
  return /^\d{6}$/ =~ time
end

def run_import
  directory = get_directory()
  if !Dir.exists?(directory)
    return false
  end

  training_directories = Dir.glob("#{directory}/*/E/*/")

  training_directories.each do |training_directory|
    training_directory.slice! "#{directory}/"

    date = training_directory[0..7]
    time = training_directory[11..16]

    training = Training.new(date: "#{date} #{time}")
    #training.save
  end
end

