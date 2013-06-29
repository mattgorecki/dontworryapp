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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @adventure }
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
    @adventure = Adventure.new(params[:adventure])

    respond_to do |format|
      if @adventure.save
        parse_data(params[:adventure][:data]) if params[:adventure][:data]

        format.html { redirect_to @adventure, notice: 'Adventure was successfully created.' }
        format.json { render json: @adventure, status: :created, location: @adventure }
      else
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
      if @adventure.update_attributes(params[:adventure])
        parse_data(params[:adventure][:data]) if params[:adventure][:data]

        format.html { redirect_to @adventure, notice: 'Adventure was successfully updated.' }
        format.json { head :no_content }
      else
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

private

  def parse_data(data)
    data.each do |key,value|
      unless value == ""
        case key
        when 'description'
          @adventure.description = value
        when 'start_time'
          @adventure.start_time = value
        when 'finish_time'
          @adventure.finish_time = value
        end
      end
    end
  end
end
