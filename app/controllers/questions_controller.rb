class QuestionsController < ApplicationController
  load_and_authorize_resource :category
  load_and_authorize_resource :profile
  load_and_authorize_resource :question, only: [:show, :edit, :update, :destroy]

  before_action :add_breadcrumbs
  # GET /questions
  # GET /questions.json
  def index
    @questions = @profile.questions.paginate(:page => params[:page], per_page: 10).order('created_at DESC')
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    add_breadcrumb "#{@question.text[0..60]}...", nil
  end

  # GET /questions/new
  def new
    add_breadcrumb :new, nil
    @question = @profile.questions.build
  end

  # GET /questions/1/edit
  def edit
    add_breadcrumb "Редагувати #{ @question.text[0..40] }...", nil
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to [@category, @profile, @question], notice: 'Question was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to [@category, @profile, @question], notice: 'Question was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def add_breadcrumbs
    add_breadcrumb t('breadcrumbs.categories.index'), :categories_path
    add_breadcrumb @category.title, category_path(@category)
    add_breadcrumb t('breadcrumbs.profiles.index'), category_profiles_path(@category)
    add_breadcrumb @profile.title, category_profile_path(@category, @profile)
    add_breadcrumb :index, category_profile_questions_path(@category, @profile)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:profile_id, :text)
  end
end
