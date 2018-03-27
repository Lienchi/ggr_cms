class TagsController < ApplicationController
  before_action :set_spreadsheet, only:[:create, :destroy]
  before_action :set_tag, only:[:update, :destroy]

  def create
    @tag = @spreadsheet.tags.build(tag_params)
    if @category.save
      flash[:notice] = "tag creates successfully"
      redirect_to spreadsheet_path(@spreadsheet)
    else
      @spreadsheets = Spreadsheet.all
      @tags = Tag.all
      render :spreadsheet_show
    end
  end

  def update
  if @tag.update(tag_params)
    redirect_to spreadsheet_path(@spreadsheet)
    flash[:notice] = "tag was successfully updated"
  else
    @spreadsheets = Spreadsheet.all
    @tags = Tag.all
    render :spreadsheet_show
  end
end

  def destroy
    @tag.destroy
    flash[:alert] = "tag was successfully deleted"
    redirect_to spreadsheet_path(@spreadsheet)
  end

  private

  def set_spreadsheet
    @spreadsheet = Spreadsheet.find(params[:spreadsheet_id])
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :tab, :col)
  end
end
