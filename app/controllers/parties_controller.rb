class PartiesController < ApplicationController
  # GET /parties
  # GET /parties.json

  skip_before_filter :require_user, :only=> [:show]

  def index

    @trainer = Trainer.find(session[:user_id])

    if @trainer.admin == 1
    	@parties = Party.all(:order => :name.asc)
    else
	@parties = Party.where(:trainer_id => @trainer.id).sort(:name)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parties }
    end
  end

  # GET /parties/1
  # GET /parties/1.json
  def show
    if params[:name]
	@party = Party.where(:name => params[:name]).first
    else
	@party = Party.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @party }
    end
  end

  # GET /parties/new
  # GET /parties/new.json
  def new
      @trainer = Trainer.find(session[:user_id])
      @party = Party.new

      if @trainer.party.nil?
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @party }
      end
    else
        @party = @trainer.party
	respond_to do |format|
          format.html { redirect_to @party, :notice => "You already have a party." }
        end
   end
  end

  # GET /parties/id/remove
  def remove

      @trainer = Trainer.find(session[:user_id])
      @party = Party.find(@trainer.party.id.to_s)
      @pokemon = Pokemon.find(params[:id])

      unless (@pokemon.nil? && @party.nil?)
      	@party.pokemon.delete @pokemon.id
        if @party.save
        respond_to do |format|
          format.html { redirect_to @party, :notice => "Removed Pokemon from party." }
        end
      end 
    else
	respond_to do |format|
          format.html { redirect_to @party, :notice => "Failed to remove Pokemon from party." }
        end
   end
  end

  # GET /parties/1/edit
  def edit
    @party = Party.find(params[:id])
  end

  # POST /parties
  # POST /parties.json
  def create
    @trainer = Trainer.find(session[:user_id])
    @party = Party.new(params[:party])
    @trainer.party = @party
    @party.trainer = @trainer

    respond_to do |format|
      if @party.save
        format.html { redirect_to @party, notice: 'Party was successfully created.' }
        format.json { render json: @party, status: :created, location: @party }
      else
        format.html { render action: "new" }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parties/1
  # PUT /parties/1.json
  def update
    @party = Party.find(params[:id])

    respond_to do |format|
      if @party.update_attributes(params[:party])
        format.html { redirect_to @party, notice: 'Party was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parties/1
  # DELETE /parties/1.json
  def destroy
    @party = Party.find(params[:id])
    @party.destroy

    respond_to do |format|
      format.html { redirect_to parties_url }
      format.json { head :no_content }
    end
  end
end
