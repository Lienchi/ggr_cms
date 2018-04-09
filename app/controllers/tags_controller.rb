class TagsController < ApplicationController
  before_action :set_tag, only:[:update, :destroy]

  def update
    if @tag.update(tag_params)
      if @tag.name.blank?
        @tag.name = nil
        @tag.save
        redirect_to spreadsheet_path(@tag.tab.spreadsheet.id)
        flash[:alert] = "Name can't be blank"
      else
        redirect_to spreadsheet_path(@tag.tab.spreadsheet.id)
        flash[:notice] = "Tag was successfully updated"
      end  
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
    params.require(:tag).permit(:name, :id, :category_id)
  end
end
