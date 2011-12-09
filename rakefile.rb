task :default => [:fetch]

task :fetch do
    ruby "fetch.rb"
end