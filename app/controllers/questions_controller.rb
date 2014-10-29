class QuestionsController < ApplicationController
  load_and_authorize_resource :category
  load_and_authorize_resource :subcategory
  load_and_authorize_resource :profile
  load_and_authorize_resource :question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = @profile.questions
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = @profile.build
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to [@category, @subcategory, @profile, @question], notice: 'Question was successfully created.' }
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
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
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

  def upload_file
    data = YAML.load(params[:questions_file].read).with_indifferent_access

    category = Category.create title: data[:category][:title]
    subcategory = Subcategory.create title: data[:category][:subcategory][:title], category_id: category.id
    profile = Profile.create title: data[:category][:subcategory][:profile][:title], subcategory_id: subcategory.id

    data[:category][:subcategory][:profile][:questions].each do |question_hash|
      question = Question.create profile_id: profile.id, text: question_hash[:text]
      question_hash[:answers].each_with_index do |answer, index|
        Answer.create text: answer[1], question_id: question.id, correct: (index == 0 )
      end
    end

    redirect_to category_subcategory_profile_questions_path(category, subcategory, profile), notice: "Questions was successfully added."
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:profile_id, :text)
  end
end
