class SnsFeedsWorker
  include Sidekiq::Worker

  def perform(current_user_id)
    puts 'PERFORM'
    # instagram feeds
    instauser = Instauser.find_by_id current_user_id
    instauser.fetch_instagram_timeline if instauser

    puts 'Fetch feeds successfully'
  end

end
