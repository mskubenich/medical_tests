class ProfilesController < ApplicationController
  load_and_authorize_resource :category
  load_and_authorize_resource :profile, only: [:show, :edit, :update, :destroy, :ask, :send_result]

  include ProfilesHelper

  before_action :add_breadcrumbs
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = @category.profiles
  end

  def ask
    add_breadcrumb @profile.title, category_profile_path(@category, @profile)
    add_breadcrumb :ask, nil
    @profile.session = nil if params[:reset]
    @profile.save
    @profile.generate_state
    @question = @profile.questions.where(id: @profile.available_questions.keys).limit(1).order("RANDOM()").first
  end

  def send_result
    @profile.generate_state
    @profile.session[params[:question_id].to_i][:success] = params[:success]
    @profile.save
    render partial: 'state'
  end
  # GET /profiles/1
  # GET /profiles/1.json
  def show
    add_breadcrumb @profile.title, category_profile_path(@category, @profile)
  end

  # GET /profiles/new
  def new
    add_breadcrumb :new, nil
    @profile = @category.profiles.build
  end

  # GET /profiles/1/edit
  def edit
    add_breadcrumb "Редагувати #{ @profile.title }", nil
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to [@category, @profile], notice: 'Profile was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to [@category, @profile], notice: 'Profile was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to category_profiles_url(@category), notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def add_breadcrumbs
    add_breadcrumb t('breadcrumbs.categories.index'), :categories_path
    add_breadcrumb @category.title, category_path(@category)
    add_breadcrumb :index, category_profiles_path(@category)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(:title, :category_id)
  end
end
