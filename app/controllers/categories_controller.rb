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
    data = YAML.load(params[:questions_file].read).with_indifferent_access

    # render text: 'ok'
    data[:categories].each do |category_hash|
      category = Category.where(title: category_hash[:title]).first_or_create
      category_hash[:questions].each do |question_hash|
        question = Question.create category_id: category.id, text: question_hash[:text]
        question_hash[:answers].each_with_index do |answer_hash, index|
          question.answers << Answer.new({
                                             text: answer_hash[:text],
                                             question_id: question.id,
                                             points: answer_hash[:points].to_i,
                                             id: index + 1
                                         })
        end
        question.save!
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
    @question = @category.questions.where.not(id: @category.session).limit(1).order("RAND()").first
    if @question
      render json: { question: @question, answers: @question.answers.shuffle }
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
      answer = question.answers.select{|answer| answer.id == answer_id.to_i}.try(:first)
      result[answer_id] = answer.points.to_i > 0
      if answer && answer_value == true
        @category.points += answer.points.to_i

      end
    end

    @category.session << params[:question_id].to_i
    @category.save

    render json: result
  end

  def state
    render json: @category.state
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
