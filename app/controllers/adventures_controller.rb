class AdventuresController < ApplicationController
  before_filter :authenticate_user!
  # GET /adventures
  # GET /adventures.json
  def index
    @adventures = Adventure.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @adventures }
    end
  end

  # GET /adventures/1
  # GET /adventures/1.json
  def show
    @adventure = Adventure.find(params[:id])

    if @adventure.validate_base_events_exist == true
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @adventure }
      end
    else
      redirect_to edit_adventure_path(@adventure), notice: "Missing input"
    end
  end

  # GET /adventures/new
  # GET /adventures/new.json
  def new
    @adventure = Adventure.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @adventure }
    end
  end

  # GET /adventures/1/edit
  def edit
    @adventure = Adventure.find(params[:id])
  end

  # POST /adventures
  # POST /adventures.json
  def create
    @adventure = Adventure.new

    respond_to do |format|
      if @adventure.save && @adventure.update_attributes(params[:adventure]) && @adventure.validate_base_events_exist
        format.html { redirect_to @adventure, notice: 'Adventure was successfully created.' }
        format.json { render json: @adventure, status: :created, location: @adventure }
      else
        @adventure.missing_base_events
        # needed to save before adding events, rollback with destroy
        @adventure.destroy
        format.html { render action: "new" }
        format.json { render json: @adventure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /adventures/1
  # PUT /adventures/1.json
  def update
    @adventure = Adventure.find(params[:id])

    respond_to do |format|
      if @adventure.update_attributes(params[:adventure]) && @adventure.validate_base_events_exist

        format.html { redirect_to @adventure, notice: 'Adventure was successfully updated.' }
        format.json { head :no_content }
      else
        @adventure.missing_base_events
        format.html { render action: "edit" }
        format.json { render json: @adventure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adventures/1
  # DELETE /adventures/1.json
  def destroy
    @adventure = Adventure.find(params[:id])
    @adventure.destroy

    respond_to do |format|
      format.html { redirect_to adventures_url }
      format.json { head :no_content }
    end
  end

end
