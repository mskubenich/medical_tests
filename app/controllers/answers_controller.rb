class AnswersController < ApplicationController
  load_and_authorize_resource :category
  load_and_authorize_resource :question
  load_and_authorize_resource :answer, only: [:edit, :update, :destroy]

  before_action :add_breadcrumbs

  def index
    @answers = @question.answers
  end

  def new
    add_breadcrumb :new, nil
    @answer = @question.answers.build
  end

  def edit
    add_breadcrumb "Редагувати #{ @answer.text[0..40] }...", nil
  end

  def create
    @answer = @question.answers.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to category_question_answers_path(@category, @question), notice: 'Answer was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to category_question_answers_path(@category, @question), notice: 'Question was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to category_question_answers_path(@category, @question), notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def add_breadcrumbs
    add_breadcrumb t('breadcrumbs.categories.index'), :categories_path
    add_breadcrumb @category.title, category_questions_path(@category)
    add_breadcrumb @question.text, category_question_answers_path(@category, @question)
  end

  def answer_params
    params.require(:answer).permit(:text, :points)
  end
end
