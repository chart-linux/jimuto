namespace :db do
  namespace :seed do
    task :all => :environment do
      load(Rails.root + 'db/seeds/except_requests.rb')
      load(Rails.root + 'db/seeds/requests.rb')
      load(Rails.root + 'db/seeds/solutions.rb')
    end

    Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].each do |filename|
      task_name = File.basename(filename, '.rb').intern
      task task_name => :environment do
        load(filename) if File.exist?(filename)
        puts "Success in creating data: " + filename.to_s
      end
    end
  end
end
