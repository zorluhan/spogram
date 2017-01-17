task :sns_feeds_worker => :environment do
  puts 'SNS FEEDS WORKER - rake task start'
  
  instausers = Instauser.all

  instausers.find_each do |instauser|
    instauser.fetch_instagram_timeline
  end

  puts 'SNS FEEDS WORKER - rake task end'
end