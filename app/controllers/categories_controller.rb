class CategoriesController < ApplicationController
  load_and_authorize_resource :category, only: [:show, :edit, :update, :destroy, :ask, :send_result, :state, :next_question, :answer_question, :reset_game]
  add_breadcrumb :index, :categories_path

  def index
    @categories = Category.all
  end

  def new
    add_breadcrumb :new, nil
    @category = Category.new
  end

  def edit
    add_breadcrumb "Редагувати #{ @category.title }", nil
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to category_questions_path(@category), notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_questions_path(@category), notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload_file
    Category.destroy_all

    data = YAML.load(params[:questions_file].read).with_indifferent_access

    # render text: 'ok'
    data[:categories].each do |category_hash|
      category = Category.where(title: category_hash[:title]).first_or_create
      category_hash[:questions].each do |question_hash|
        question = Question.create category_id: category.id, text: question_hash[:text]
        question_hash[:answers].each do |answer_hash|
          Answer.create text: answer_hash[:text], question_id: question.id, points: answer_hash[:points].to_i
        end
      end
    end

    redirect_to categories_path(), notice: "Questions was successfully added."
  end

  def ask

  end

  def reset_game
    @category.points = 0
    @category.session = nil
    @category.save
    render json: {ok: true}
  end

  def next_question
    @category.generate_state
    @category.save
    @question = @category.questions.where(id: @category.available_questions.keys).limit(1).order("RANDOM()").first
    if @question
      render json: { question: @question, answers: @question.answers.select(:id, :text, :points).shuffle }
    else
      render json: { question: nil, answers: []}
    end
  end

  def answer_question
    @category.generate_state

    params[:answer] ||= []
    question = Question.find params[:question_id]

    result = {}

    params[:answer].each do |answer_id, answer_value|
      answer = question.answers.where(id: answer_id).try(:first)
      result[answer_id] = answer.points.to_i > 0
      if answer && answer_value == true
        @category.points += answer.points.to_i

      end
    end

    @category.session[params[:question_id].to_i][:success] = true
    @category.save

    render json: result
  end

  def state
    @category.generate_state
    @category.save
    questions_count = @category.session.keys.count
    finished_questions_count = questions_count - @category.available_questions_count
    points = @category.points.to_i
    available_points = questions_count * 100
    finished_questions_percentage = ((finished_questions_count * 100.0)/questions_count).round(1)

    render json: {
               questions_count:          questions_count,
               finished_questions_count: finished_questions_count,
               points:  points,
               available_points:  available_points,
               finished_questions_percentage: finished_questions_percentage
           }
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
