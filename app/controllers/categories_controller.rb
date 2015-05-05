class CategoriesController < ApplicationController
  load_and_authorize_resource :category, only: [:show, :edit, :update, :destroy]
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

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
