class VotingBoothController < ApplicationController
  before_filter :require_login

  # this sets up the full ballot
  def vote
    @ballot = Ballot.where({:user_id => current_user, :election_id => params[:election_id]}).first_or_initialize

    respond_to do |format|
      format.html # vote.html.haml
      format.json { render json => @ballot }
    end
  end

  # this is the ballot submission method
  def cast_ballot
    save_result = false
    Ballot.transaction do 
      rankings =  Rack::Utils.parse_nested_query(params[:ballot_data])["ranking"]
      # puts request.inspect
      @ballot = Ballot.where({:user_id => current_user, :election_id => params[:election_id]}).first_or_initialize
      @ballot.votes.each do |vote|
        vote.destroy
      end
      rankings.each_index do |i|
        @ballot.votes.build( { :rank => i, :candidate => Candidate.find(rankings[i]) } )
      end
      
      # puts @ballot.inspect

      save_result = @ballot.save
      puts "cast_ballot save return val: #{save_result}"
    end

    respond_to do |format|
      if save_result
        tally_votes(@ballot.election)
        format.html { redirect_to root_path, :notice => "Thank you for voting!" }
        format.json { render :json => @ballot, :status => :created, :location =>  @ballot }
      else
        format.html { render :action => "vote" }
        format.json { render :json => @ballot.errors, :status => :unprocessable_entity }
      end
    end
  end
end
