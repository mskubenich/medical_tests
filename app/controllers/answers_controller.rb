class AnswersController < ApplicationController
  load_and_authorize_resource :category
  load_and_authorize_resource :question

  before_action :add_breadcrumbs

  def index
    @answers = @question.answers
  end

  def new
    add_breadcrumb :new, nil
    @answer = Answer.new question_id: @question.id
  end

  def edit
    @answer = @question.answers.select{|answer| answer.id == params[:id].to_i}.try(:first)
    add_breadcrumb "Редагувати #{ @answer.text[0..40] }...", nil
  end

  def create
    @answer = Answer.new question_id: @question.id, text: params[:answer][:text], points: params[:answer][:points].to_i
    @answer.set_id

    @question.answers << @answer
    @question.save

    redirect_to category_question_answers_path(@category, @question), notice: 'Answer was successfully created.'
  end

  def update
    @answers = @question.answers

    @answers.each do |answer|
      if answer.id == params[:id].to_i
        answer.text = params[:answer][:text]
        answer.points = params[:answer][:points]
      end
    end

    @question.answers = @answers
    @question.save

    redirect_to category_question_answers_path(@category, @question), notice: 'Question was successfully updated.'
  end

  def destroy
    @answers = @question.answers.delete_if{|answer| answer.id == params[:id].to_i}

    @question.answers = @answers
    @question.save


    redirect_to category_question_answers_path(@category, @question), notice: 'Answer was successfully destroyed.'
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
