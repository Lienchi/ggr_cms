class TagsController < ApplicationController
  before_action :set_spreadsheet, only:[:create, :destroy]

  def create
    @spreadsheet = Spreadsheet.find(params[:spreadsheet_id])
    @tag = @spreadsheet.tags.build(tag_params)
    @tag.save!
    redirect_to spreadsheet_path(@spreadsheet)
  end

  def destroy
    @spreadsheet = Spreadsheet.find(params[:spreadsheet_id])
    @tag = Tag.find(params[:id])
    @tag.destroy #可以加個確認訊息
    redirect_to spreadsheet_path(@spreadsheet)
  end

  private

  def set_spreadsheet
    @spreadsheet = Spreadsheet.find(params[:spreadsheet_id])
  end

  def tag_params
    params.require(:tag).permit(:name, :tab, :col)
  end
end
