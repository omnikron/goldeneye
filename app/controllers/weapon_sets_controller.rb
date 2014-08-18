class WeaponSetsController < ApplicationController
  before_action :set_weapon_set, only: [:show, :edit, :update, :destroy]

  # GET /weapon_sets
  # GET /weapon_sets.json
  def index
    @weapon_sets = WeaponSet.all
  end

  # GET /weapon_sets/1
  # GET /weapon_sets/1.json
  def show
  end

  # GET /weapon_sets/new
  def new
    @weapon_set = WeaponSet.new
  end

  # GET /weapon_sets/1/edit
  def edit
  end

  # POST /weapon_sets
  # POST /weapon_sets.json
  def create
    @weapon_set = WeaponSet.new(weapon_set_params)

    respond_to do |format|
      if @weapon_set.save
        format.html { redirect_to @weapon_set, notice: 'Weapon set was successfully created.' }
        format.json { render :show, status: :created, location: @weapon_set }
      else
        format.html { render :new }
        format.json { render json: @weapon_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weapon_sets/1
  # PATCH/PUT /weapon_sets/1.json
  def update
    respond_to do |format|
      if @weapon_set.update(weapon_set_params)
        format.html { redirect_to @weapon_set, notice: 'Weapon set was successfully updated.' }
        format.json { render :show, status: :ok, location: @weapon_set }
      else
        format.html { render :edit }
        format.json { render json: @weapon_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weapon_sets/1
  # DELETE /weapon_sets/1.json
  def destroy
    @weapon_set.destroy
    respond_to do |format|
      format.html { redirect_to weapon_sets_url, notice: 'Weapon set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weapon_set
      @weapon_set = WeaponSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weapon_set_params
      params[:weapon_set]
    end
end
