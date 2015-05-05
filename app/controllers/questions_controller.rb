class QuestionsController < ApplicationController
  load_and_authorize_resource :category
  load_and_authorize_resource :question, only: [:show, :edit, :update, :destroy]

  before_action :add_breadcrumbs

  def index
    @questions = @category.questions.paginate(:page => params[:page], per_page: 10).order('created_at DESC')
  end

  def new
    add_breadcrumb :new, nil
    @question = @category.questions.build
  end

  def edit
    add_breadcrumb "Редагувати #{ @question.text[0..40] }...", nil
  end

  def create
    @question =  @category.questions.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to category_question_answers_path(@category, @question), notice: 'Question was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to category_question_answers_path(@category, @question), notice: 'Question was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to category_questions_url(@category), notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def add_breadcrumbs
    add_breadcrumb t('breadcrumbs.categories.index'), :categories_path
    add_breadcrumb @category.title, category_questions_path(@category, @profile)
  end

  def question_params
    params.require(:question).permit(:profile_id, :text)
  end
end
