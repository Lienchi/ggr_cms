class TagsController < ApplicationController
  require 'google/apis/sheets_v4'
  before_action :set_api
#  before_action :set_tag, only:[:update, :destroy]

  def create
    @tab_index = params[:index]
    range = ("A".."ZZ").to_a
    @columns =[]
    @service.get_spreadsheet_values(session["spreadsheet_id"], session["tabs"][@tab_index.to_i]["name"]).values[0].each_with_index do |column, index|
      @columns << { index: index, name: column, category_id: 1, xml_name: nil, tab_id: @tab_index, range: range[index] }
    end   
  end


  def update
    @column = params[:column]
    session["js"][ @column[:tab_id]][@column[:index]] = {name: @column[:xml_name], range: session["tabs"][@column[:tab_id].to_i]["name"]+"!"+ @column[:range]+ ":" +@column[:range] , type: @column[:category_id]}
  end
 

  def destroy
    @column = params[:column]
    session["js"][ @column[:tab_id]].delete(@column[:index])
  end

 

  private

  def set_api
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.key = Rails.application.config_for(:api)["api_key"]
    @service.authorization = nil
  end


  # def update
  #   if @tag.update(tag_params)
  #     if @tag.name.blank?
  #       @tag.name = nil
  #       @tag.save
  #       redirect_to spreadsheet_path(@tag.tab.spreadsheet.id)
  #       flash[:alert] = "Name can't be blank"
  #     else
  #       redirect_to spreadsheet_path(@tag.tab.spreadsheet.id)
  #       flash[:notice] = "Tag was successfully updated"
  #     end  
  #   else
  #     @spreadsheets = Spreadsheet.all
  #     @tags = Tag.all
  #     render :spreadsheet_show
  #   end
  # end


  # private

  # def set_tag
  #   @tag = Tag.find(params[:id])
  # end

  # def tag_params
  #   params.require(:tag).permit(:name, :id, :category_id)
  # end
end
