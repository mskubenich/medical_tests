class SubcategoriesController < ApplicationController
  load_and_authorize_resource :category
  load_and_authorize_resource :subcategory, only: [:show, :edit, :update, :destroy]

  before_action :add_breadcrumbs
  # GET /subcategories
  # GET /subcategories.json
  def index
    @subcategories = @category.subcategories
  end

  # GET /subcategories/1
  # GET /subcategories/1.json
  def show
    add_breadcrumb @subcategory.title, category_subcategory_path(@category, @subcategory)
  end

  # GET /subcategories/new
  def new
    add_breadcrumb :new, nil
    @subcategory = @category.subcategories.build
  end

  # GET /subcategories/1/edit
  def edit
    add_breadcrumb "Редагувати #{ @subcategory.title }", nil
  end

  # POST /subcategories
  # POST /subcategories.json
  def create
    @subcategory = Subcategory.new(subcategory_params)

    respond_to do |format|
      if @subcategory.save
        format.html { redirect_to [@category, @subcategory], notice: 'Subcategory was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /subcategories/1
  # PATCH/PUT /subcategories/1.json
  def update
    respond_to do |format|
      if @subcategory.update(subcategory_params)
        format.html { redirect_to [@category, @subcategory], notice: 'Subcategory was successfully updated.' }
        format.json { render :show, status: :ok, location: @subcategory }
      else
        format.html { render :edit }
        format.json { render json: @subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subcategories/1
  # DELETE /subcategories/1.json
  def destroy
    @subcategory.destroy
    respond_to do |format|
      format.html { redirect_to category_subcategories_url(@category), notice: 'Subcategory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def add_breadcrumbs
    add_breadcrumb t('breadcrumbs.categories.index'), :categories_path
    add_breadcrumb @category.title, category_path(@category)
    add_breadcrumb :index, category_subcategories_path(@category)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def subcategory_params
    params.require(:subcategory).permit(:category_id, :title, :description)
  end
end
