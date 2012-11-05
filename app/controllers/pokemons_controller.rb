class PokemonsController < ApplicationController
  # GET /pokemons
  # GET /pokemons.json

  def index
    @trainer = Trainer.find(session[:user_id])
    
    if @trainer.admin == 1
    	@pokemons = Pokemon.all(:order => :pokedex_number.asc)
    else
	@pokemons = Pokemon.where(:trainer_id => @trainer.id).sort(:pokedex_number)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pokemons }
    end
  end

  # GET /pokemons/1
  # GET /pokemons/1.json
  def show
    @pokemon = Pokemon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pokemon }
    end
  end

  # GET /pokemons/1/add
  def add

    @pokemon = Pokemon.find(params[:id])
    @trainer = Trainer.find(session[:user_id])

    puts "***********************"
    puts "\n"
    puts @trainer.party.blank?

    if @trainer.party.blank?
	respond_to do |format|	
	   format.html { redirect_to @trainer, notice: 'Please create a party first.' }
	end    
    else

      unless @trainer.party.pokemon.to_a.any? { |pokemon| pokemon == @pokemon }
	@trainer.party.pokemon.push @pokemon

        if (@trainer.party.save && @pokemon.save && @trainer.save) 
	  respond_to do |format|
       	    format.html { redirect_to @trainer.party, notice: 'Pokemon was successfully added.' }
      	  end
        end
      else
        respond_to do |format|
       	    format.html { redirect_to @trainer.party, notice: 'Pokemon was already added.' }
        end
      end
    end
  end

  # GET /pokemons/new
  # GET /pokemons/new.json
  def new
    @pokemon = Pokemon.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pokemon }
    end
  end

  # GET /pokemons/1/edit
  def edit
    @pokemon = Pokemon.find(params[:id])
  end

  # POST /pokemons
  # POST /pokemons.json
  def create

    @pokemon = Pokemon.new(params[:pokemon])
    @trainer = Trainer.find(session[:user_id])
    @pokemon.trainer = @trainer
    @trainer.pokemon.push @pokemon

    respond_to do |format|
      if @pokemon.save
        format.html { redirect_to @pokemon, notice: 'Pokemon was successfully created.' }
        format.json { render json: @pokemon, status: :created, location: @pokemon }
      else
        format.html { render action: "new" }
        format.json { render json: @pokemon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pokemons/1
  # PUT /pokemons/1.json
  def update
    @pokemon = Pokemon.find(params[:id])

    respond_to do |format|
      if @pokemon.update_attributes(params[:pokemon])
        format.html { redirect_to @pokemon, notice: 'Pokemon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pokemon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokemons/1
  # DELETE /pokemons/1.json
  def destroy
    @pokemon = Pokemon.find(params[:id])
    @pokemon.destroy

    respond_to do |format|
      format.html { redirect_to pokemons_url }
      format.json { head :no_content }
    end
  end
end
