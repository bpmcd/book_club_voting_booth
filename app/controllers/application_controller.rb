require 'rubyvote'

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :tally_votes

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must login first!"
      redirect_to root_path
    end
  end

  def logged_in?
    !!current_user
  end

  def require_admin
    unless current_user.is_admin?
      flash[:error] = "You are not authorized to access the requested page."
      redirect_to root_path
    end
  end

  def tally_votes(election)
    ballot_ary = []
    election.reload
    puts "election ballots: #{election.ballots}"
    election.ballots.each do |ballot|
      vote_ary = []
      puts "ballot #{ballot.id} votes: #{ballot.votes}"
      ballot.votes.each do |v|
        vote_ary[v.rank]= v.candidate
      end
      ballot_ary << vote_ary unless vote_ary.empty? || vote_ary.nil?
    end
    puts
    puts "ballot_ary: #{ballot_ary.inspect}"
    result = InstantRunoffAllVote.new(ballot_ary).result
    # puts "winner is: #{result.inspect}"
    puts

    if result.winner?
      election.winner = result.winners[0].name
      election.save
    end
    result
  end
end
