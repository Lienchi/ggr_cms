class TagsController < ApplicationController
  def create
    @spreadsheet = Spreadsheet.find(params[:spreadsheet_id])
    @tag = @spreadsheet.tags.build(tag_params)
    @tag.save!
    redirect_to spreadsheet_path(@spreadsheet)
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :tab, :col)
  end
end
