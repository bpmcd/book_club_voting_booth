require 'rubyvote'

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    puts "in #require_login"
    unless logged_in?
      flash[:error] = "You must login first!"
      redirect_to root_path
    end
  end

  def logged_in?
    puts "in #logged_in?"
    !!current_user
  end

  def tally_votes(election)
    ballot_ary = []
    election.reload
    election.ballots.each do |ballot|
      vote_ary = []
      ballot.votes.each do |v|
        vote_ary[v.rank]= v.candidate
      end
      ballot_ary << vote_ary
    end
    result = InstantRunoffVote.new(ballot_ary).result
    puts "winner is: #{result.winner.inspect}"

    save_results = election.save
    election.winner
  end
end