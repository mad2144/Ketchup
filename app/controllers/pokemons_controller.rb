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

    if @trainer.party.blank?
	respond_to do |format|	
	   format.html { redirect_to @trainer, notice: 'Please create a party first.' }
	end    
    else

      unless ((@trainer.party.pokemon.to_a.any? { |pokemon| pokemon == @pokemon }) || @trainer.party.pokemon.to_a.length >= 6)
	@trainer.party.pokemon.push @pokemon.id

        if (@trainer.party.save && @pokemon.save && @trainer.save) 
	  respond_to do |format|
       	    format.html { redirect_to @trainer.party, notice: 'Pokemon was successfully added.' }
      	  end
        end
      else
        respond_to do |format|
       	    format.html { redirect_to @trainer.party, notice: 'Pokemon was already added or party is at its limit.' }
        end
      end
    end
  end

  def attack
    #find the two pokemon
    @p1 = Pokemon.find(params[:id_1])
    @p2 = Pokemon.find(params[:id_2])

    puts @p1
    puts @p2
    #find the battle
    @battle = Battle.first(:p1 => @p1.id.to_s, :p2 => @p2.id.to_s)

    if rand(100) <= (@p2.SPD - @p1.ATK)
	#they dodge you
	dmg = @p2.ATK - @p1.ATK
    
        if dmg < 0
	  dmg = 0
	end

        @p1.HP = @p1.HP - dmg

        if @p1.HP <= 0
	  @p1.fainted = true
          @p1.HP = 0
	end

	@p1.save
        @p2.save

        respond_to do |format|
       	  format.html { redirect_to @battle, notice: @p2.name + ' dodged your attack and hit you for ' + dmg + ' damage!' }
      	end
      else
	  #they don't dodge you

          dmg = @p1.ATK - @p2.DEF
        
	  if dmg < 0
	     dmg = 0
	  end 

	  @p2.HP = @p2.HP - dmg
	
	  if @p2.HP <= 0
	    @p2.fainted = true
            @p2.HP = 0
	  end

          notice = "You hit them for " + dmg.to_s

          #if they can attack back
          if not @p2.fainted
           if rand(100) > (@p1.SPD - @p2.ATK)
      	    #you don't dodge

            dmg2 = @p2.ATK - @p1.DEF
	    
            if dmg2 < 0
		dmg2 = 0
	    end

	    @p1.HP = @p1.HP - dmg2

	    if @p1.HP <= 0
	      @p1.fainted = true
              @p1.HP = 0
	    end

	    notice += " and you are hit back for " + dmg2.to_s 
 
            else
	      notice += " and you dodge their attack!"
	    end
 	   else
		notice += " and they fainted!"
           end
           
	    @p1.save
	    @p2.save
            respond_to do |format|
       	      format.html { redirect_to @battle, notice: notice}
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
