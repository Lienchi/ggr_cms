class TagsController < ApplicationController
  before_action :set_tag, only:[:update, :destroy]

  def update
    if @tag.update(tag_params)
      redirect_to spreadsheet_path(@tag.tab.spreadsheet.id)
      flash[:notice] = "tag was successfully updated"
    else
      @spreadsheets = Spreadsheet.all
      @tags = Tag.all
      render :spreadsheet_show
    end
  end


  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :id)
  end
end
